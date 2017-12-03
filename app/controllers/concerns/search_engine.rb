# frozen_string_literal: true

module SearchEngine
   extend ActiveSupport::Concern

end

class Array
   def create_or_query(field)
      if self.count > 0
         self.join(" OR #{field} = ")
      else
         self.to_s.replace('0')
      end
   end
end

class Event < ApplicationRecord
   PUNC = /[[:blank:]|\s|、|,]/
   PERFORMER_ROLES = ['シテ', 'ワキ', '狂言']
   ACCOMPANIST_ROLES = ['笛', '小鼓', '大鼓', '太鼓']

   def self.search_results(params)
      results = self.where(publishing_status: 3).order(start_date: :desc)
      #binding.pry
      results = results.search_by_date(params)
      results = results.search_by_locations(params)
      results = results.search_by_performers(params)
      results = results.search_by_programs(params)
      results = results.search_by_categories(params)
      return results
   end

   # 疑似検索エンジン

   # Search params contains the following keys
   #
   # { search: { start_date: DateTime,
   #             end_date: DateTime,
   #             locations: String,
   #             venue: String,
   #             performer: String,
   #             accompanist: String,
   #             program: String,
   #             category: Integer }}
   class ActiveRecord_Relation
      def search_by_date(params)
         records = self.dup
         records = records.where("start_date >= ?", params[:start_date]) if params[:start_date].present?
         records = records.where("start_date <= ?", (params[:end_date].in_time_zone + 1.day).strftime("%Y-%m-%d")) if params[:end_date].present?
         return records
      end

      def search_by_place(params, field, column)
         records = self.dup
         locations = Array.new()
         params[:"#{field}"].split(PUNC).each do |location|
            locations << Place.where("#{column} LIKE '%#{location}%'").ids
         end
         locations = locations.flatten.uniq.create_or_query('place_id')
         records = records.where("place_id = #{locations}")
         return records
      end

      def search_by_locations(params)
         records = self.dup
         records = records.search_by_place(params, 'locations', 'address') if params[:locations].present?
         records = records.search_by_place(params, 'venue', 'title') if params[:venue].present?
         return records
      end

      def search_roles(params, roles, field)
         records = self.dup
         performer_ids = Array.new()
         roles = roles.map { |role| role = "title LIKE '%#{role}%'" }.join(' OR ')
         style_ids = Style.where(roles).ids.join(' OR style_id = ')
         performers = Performer.where("style_id = #{style_ids}")
         params[:"#{field}"].split(PUNC).each do |performer|
            performer_ids << performers.where("full_name LIKE '%#{performer}%'").ids
         end
         performer_ids = performer_ids.flatten.uniq.create_or_query('performer_id')
         ev_performer_ids = EventPerformer.where("performer_id = #{performer_ids}").pluck(:event_program_id).uniq.create_or_query('id')
         ev_program_ids = EventProgram.where("id = #{ev_performer_ids}").pluck(:event_id).uniq.create_or_query('id')
         records = records.where("id = #{ev_program_ids}")
         return records
      end

      def search_by_performers(params)
         records = self.dup
         records = records.search_roles(params, PERFORMER_ROLES, 'performer') if params[:performer].present?
         records = records.search_roles(params, ACCOMPANIST_ROLES, 'accompanist') if params[:accompanist].present?
         # TODO: 特定のカテゴリを指定しての演者検索(ex. ある演者が地謡として出演など)
         # TODO: 特定の演目に出演する演者検索(ex, ある演者が「船弁慶」に出演など)
         return records
      end

      def search_by_programs(params)
         records = self.dup
         if params[:program].present?
            program_ids = Array.new()
            params[:program].split(PUNC).each do |program|
               program_ids << Program.where("title LIKE '%#{program}%'").ids
            end
            program_ids = program_ids.flatten.uniq.create_or_query('program_id')
            ev_program_ids = EventProgram.where("program_id = #{program_ids}").pluck(:event_id).uniq.create_or_query('id')
            records = records.where("id = #{ev_program_ids}")
         end
         return records
      end

      def search_by_categories(params)
         records = self.dup
         if params[:category].present?
            categories = params[:category].split(/,/).create_or_query('category')
            records = records.where("category = #{categories}")
         end
         return records
      end
   end

end
