# frozen_string_literal: true

module SearchEngine
   extend ActiveSupport::Concern

   # 疑似検索エンジン
   def search_result
      search_params = { start_date:  params[:search][:start_date],
                        end_date:    params[:search][:end_date],
                        keywd:       params[:search][:keywd],
                        locations:   params[:search][:locations] }

      search_result = public_events(Event.all.order(start_date: :desc))
      # 日付フィルター
      # 範囲(from)
      if search_params[:start_date] != ''
         start_query = "start_date >= '#{search_params[:start_date]}'"
         search_result = search_result.where(start_query)
      end

      # 範囲(to)
      if search_params[:end_date] != ''
         end_query = "start_date <= '#{search_params[:end_date]}'"
         search_result = search_result.where(end_query)
      end

      # 開催地フィルター
      if search_params[:locations] != ''
         locations = search_params[:locations].split(',')
         query_for_places = ''
         locations.each do |location|
            query_for_places += "address LIKE '%#{location}%' OR "
         end
         query_for_places = query_for_places[0..(query_for_places.length - 5)]
         relative_places = Place.where(query_for_places)

         locations_query = ''
         relative_places.each do |place|
            locations_query += "place_id = #{place.id} OR "
         end
         locations_query = locations_query[0..(locations_query.length - 5)]
         search_result = search_result.where(locations_query)
      end

      # キーワードフィルター
      if search_params[:keywd] != ''
         keywds = search_params[:keywd].split(/\s/)
         keywd_query = ''

         # 出演者
         query_for_performers = ''
         keywds.each do |keywd|
            query_for_performers += "full_name LIKE '%#{keywd}%' OR "
         end
         query_for_performers = query_for_performers[0..(query_for_performers.length - 5)]
         relative_performers = Performer.where(query_for_performers)

         event_performers = []
         relative_performers.each do |performer|
            event_performers << EventPerformer.where("performer_id = #{performer.id}")
         end
         event_performers = event_performers.flatten

         event_programs = []
         event_performers.each do |ev_performer|
            event_programs << EventProgram.find(ev_performer.event_program_id)
         end
         event_programs = event_programs.uniq

         performers_query = ''
         event_programs.each do |ev_program|
            performers_query += "id = #{ev_program.event_id} OR "
         end
         keywd_query += performers_query

         # 演目
         query_for_programs = ''
         keywds.each do |keywd|
            query_for_programs += "title LIKE '%#{keywd}%' OR "
         end
         query_for_programs = query_for_programs[0..(query_for_programs.length - 5)]
         relative_programs = Program.where(query_for_programs)

         event_programs = []
         relative_programs.each do |program|
            event_programs << EventProgram.where("program_id = #{program.id}")
         end
         event_programs = event_programs.flatten

         programs_query = ''
         event_programs.each do |ev_program|
            programs_query += "id = #{ev_program.event_id} OR "
         end
         keywd_query += programs_query

         # 公演名
         events_query = ''
         keywds.each do |keywd|
            events_query += "title LIKE '%#{keywd}%' OR "
         end
         keywd_query += events_query
         keywd_query = keywd_query[0..(keywd_query.length - 5)]
         search_result = search_result.where(keywd_query)
      end
      return search_result
   end
end
