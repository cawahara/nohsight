# frozen_string_literal: true

class Array
   def create_or_query(field)
      if self.count > 0
         self.join(" OR #{field} = ")
      else
         self.to_s.replace('0')
      end
   end
end

module SearchEngine
   extend ActiveSupport::Concern

   PUNC = /[[:blank:]|\s|、|,]/

   # 疑似検索エンジン
   def search_results
      results = public_events(Event.all.order(start_date: :desc))
      results = search_by_date(results)
      results = search_by_locations(results)
      results = search_by_performers(results)
      results = search_by_programs(results)
      results = search_by_categories(results)
      return results
   end

   private

   def search_by_date(records)
      records = records.where("start_date >= ?", params[:search][:start_date]) if params[:search][:start_date].present?
      records = records.where("start_date <= ?", (params[:search][:end_date].in_time_zone + 1.day).strftime("%Y-%m-%d")) if params[:search][:end_date].present?
      return records
   end

   def search_by_place(records, field, column)
      locations = Array.new()
      params[:search][field].split(PUNC).each do |location|
         locations << Place.where("#{column} LIKE '%#{location}%'").ids
      end
      locations = locations.flatten.uniq.create_or_query('place_id')
      records = records.where("place_id = #{locations}")
      return records
   end

   def search_by_locations(records)
      records = search_by_place(records, 'locations', 'address') if params[:search][:locations].present?
      records = search_by_place(records, 'venue', 'title') if params[:search][:venue].present?
      return records
   end

   def search_roles(records, roles, field)
      performer_ids = Array.new()
      roles = roles.map { |role| role = "title LIKE '%#{role}%'" }.join(' OR ')
      style_ids = Style.where(roles).ids.join(' OR style_id = ')
      performers = Performer.where("style_id = #{style_ids}")
      params[:search][field].split(PUNC).each do |performer|
         performer_ids << performers.where("full_name LIKE '%#{performer}%'").ids
      end
      performer_ids = performer_ids.flatten.uniq.create_or_query('performer_id')
      ev_performer_ids = EventPerformer.where("performer_id = #{performer_ids}").pluck(:event_program_id).uniq.create_or_query('id')
      ev_program_ids = EventProgram.where("id = #{ev_performer_ids}").pluck(:event_id).uniq.create_or_query('id')
      records = records.where("id = #{ev_program_ids}")
      return records
   end

   def search_by_performers(records)
      records = search_roles(records, ['シテ', 'ワキ', '狂言'], 'performer') if params[:search][:performer].present?
      records = search_roles(records, ['笛', '小鼓', '大鼓', '太鼓'], 'accompanist') if params[:search][:accompanist].present?
      # TODO: 特定のカテゴリを指定しての演者検索(ex. ある演者が地謡として出演など)
      # TODO: 特定の演目に出演する演者検索(ex, ある演者が「船弁慶」に出演など)
      return records
   end

   def search_by_programs(records)
      if params[:search][:program].present?
         program_ids = Array.new()
         params[:search][:program].split(PUNC).each do |program|
            program_ids << Program.where("title LIKE '%#{program}%'").ids
         end
         program_ids = program_ids.flatten.uniq.create_or_query('program_id')
         ev_program_ids = EventProgram.where("program_id = #{program_ids}").pluck(:event_id).uniq.create_or_query('id')
         records = records.where("id = #{ev_program_ids}")
      end
      return records
   end

   def search_by_categories(records)
      if params[:search][:category].present?
         categories = params[:search][:category].split(/,/).create_or_query('category')
         records = records.where("category = #{categories}")
      end
      return records
   end
end
