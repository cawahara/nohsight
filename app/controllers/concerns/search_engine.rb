# frozen_string_literal: true

module SearchEngine
   extend ActiveSupport::Concern

   # 疑似検索エンジン
   def search_result
      search_result = public_events(Event.all.order(start_date: :desc))
      # 日付フィルター
      # 範囲(from)
      search_result = date_query('from', search_params, search_result)
      # 範囲(to)
      search_result = date_query('to', search_params, search_result)
      # 開催地フィルター
      search_result = location_query(search_params, search_result)
      # キーワードフィルター
      search_result = keywd_query(search_params, search_result)
      return search_result
   end

   private

   def search_params
      return { start_date:  params[:search][:start_date],
               end_date:    params[:search][:end_date],
               keywd:       params[:search][:keywd],
               locations:   params[:search][:locations] }
   end

   def add_iterated_datas(datas, field, clause, result)
      query_for_add = ''
      query_clause = ["#{field} = ", '', ' OR ']
      query_clause = ["#{field} LIKE '%", '', "%' OR "] if clause == 'like'
      datas.each do |data|
         query_clause[1] = data
         query_for_add += query_clause.join
      end
      return omit_excessed_or_query(query_for_add, result)
   end

   def add_iterated_query(datas, field, target)
      query = ''
      datas.each do |data|
         query += "#{target} = #{data[field]} OR "
      end
      return query
   end

   def omit_excessed_or_query(query, result)
      query = query[0..(query.length - 5)]
      return result.where(query)
   end

   def add_find_result(datas, model, field)
      result = []
      datas.each do |data|
         result << model.find(data[field])
      end
      return result.uniq
   end

   def date_query(term, search_params, results)
      if term == 'from' && search_params[:start_date] != ''
         term_query = "start_date >= '#{search_params[:start_date]}'"
      elsif term == 'to' && search_params[:end_date] != ''
         term_query = "start_date <= '#{search_params[:end_date]}'"
      end
      return results.where(term_query)
   end

   def location_query(search_params, results)
      if search_params[:locations] != ''
         locations = search_params[:locations].split(',')
         relative_places = add_iterated_datas(locations, 'address', 'like', Place)
         results = add_iterated_datas(relative_places, 'address', '=', results)
      end
      return results
   end

   def performer_query_in_keywd(keywds)
      relative_performers = add_iterated_datas(keywds, 'full_name', 'like', Performer)
      ev_programs = []
      relative_performers.each do |performer|
         ev_performers = EventPerformer.where("performer_id = #{performer.id}")
         ev_programs = add_find_result(ev_performers, EventProgram, 'event_program_id')
      end
      return add_iterated_query(ev_programs, 'event_id', 'id')
   end

   def program_query_in_keywd(keywds)
      relative_programs = add_iterated_datas(keywds, 'title', 'like', Program)

      ev_programs = []
      relative_programs.each do |program|
         ev_programs << EventProgram.where("program_id = #{program.id}")
      end
      ev_programs = ev_programs.flatten
      return add_iterated_query(ev_programs, 'event_id', 'id')
   end

   def ev_query_in_keywd(keywds)
      events_query = ''
      keywds.each do |keywd|
         events_query += "title LIKE '%#{keywd}%' OR "
      end
      return events_query
   end

   def keywd_query(search_params, results)
      if search_params[:keywd] != ''
         keywds = search_params[:keywd].split(/\s/)
         keywd_query = ''
         # 出演者
         keywd_query += performer_query_in_keywd(keywds)

         # 演目
         keywd_query += program_query_in_keywd(keywds)

         # 公演名
         keywd_query += ev_query_in_keywd(keywds)
         results = omit_excessed_or_query(keywd_query, results)
      end
      return results
   end
end
