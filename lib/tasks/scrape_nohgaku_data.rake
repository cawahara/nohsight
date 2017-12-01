# frozen_string_literal: true

require 'mechanize'
require 'json'

namespace :scrape do
   desc 'Scrape event informations roughly from http://www.nohgaku.or.jp/playinginfo/index.html'
   task events: :environment do

      FILE_PATH = Rails.root.join('db/fixtures').to_s

      module SeedAttribute

         class EventConstant
            @@id = Event.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            def self.format_datetime(date, time)
               # 文字からDateTime.strftimeする
               year = Time.zone.now.year
               month = Time.zone.now.month
               date = date.slice(0, 2).to_i
               hour = time.slice(0, 2).to_i
               minute = time.slice(3, 2).to_i
               datetime = DateTime.new(year, month, date, hour, minute)
               return datetime.strftime('%Y-%m-%d %H:%M:%S')
            end

            def self.new_data(title, start_date, place_data)
               new_event = Event.new(id: self.id,
                                     title: title,
                                     start_date: start_date,
                                     official_url: place_data.official_url,
                                     place_id: place_data.id,
                                     publishing_status: 3)
               self.insert_data(new_event.attributes)
               return new_event
            end
         end

         class PlaceConstant
            @@id = Place.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            SEARCH_URI = 'https://maps.googleapis.com/maps/api/place'

            def self.find_initialized(attr, val)
               self.datas.each do |obj|
                  return Place.new(obj) if obj["#{attr}"] == val
               end
               return false
            end

            def self.search_uri(type, query)
               q_type = type == 'textsearch' ? 'query' : 'placeid'
               return "#{SEARCH_URI}/#{type}/xml?key=#{ENV['GOOGLE_API_KEY']}&#{q_type}=#{query}&language=ja"
            end

            def self.new_data(query)
               agent = Mechanize.new().get(self.search_uri('textsearch', query))
               place_id = agent.search('result')[0].css('place_id').text
               id_agent = Mechanize.new().get(self.search_uri('details', place_id))
               result = id_agent.search('result')
               new_place = self.find_initialized('title', result.css('name').text)
               if new_place == false
                  new_place = Place.new(id: self.id,
                                        title: result.css('name').text,
                                        address: result.css('formatted_address').text,
                                        official_url: result.css('website').text) if new_place == false
                  self.insert_data(new_place.attributes)
               end
               return new_place
            end
         end

         class EventProgramConstant
            @@id = EventProgram.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            def self.new_data(program_id, genre)
               new_event_program =  EventProgram.new(id: self.id,
                                                     event_id: SeedAttribute::EventConstant.id,
                                                     program_id: program_id,
                                                     genre: genre)
               self.insert_data(new_event_program.attributes)
               return new_event_program
            end
         end

         class EventPerformerConstant
            @@id = EventProgram.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            def self.new_data(performer_id)
               new_event_performer = EventPerformer.new(id: self.id,
                                                        event_program_id: SeedAttribute::EventProgramConstant.id,
                                                        performer_id: performer_id)
               self.insert_data(new_event_performer.attributes)
               return new_event_performer
            end
         end

         class ProgramConstant
            @@id = Program.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            def self.find_initialized(attr, val)
               self.datas.each do |obj|
                  return Program.new(obj) if obj["#{attr}"] == val
               end
               return false
            end

            def self.new_data(title)
               new_program = self.find_initialized('title', title)
               if new_program == false
                  new_program = Program.new(id: self.id, title: title)
                  self.insert_data(new_program.attributes)
               end
               return new_program
            end
         end

         class PerformerConstant
            @@id = Performer.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            def self.find_initialized(attr, val)
               self.datas.each do |obj|
                  return Performer.new(obj) if obj["#{attr}"] == val
               end
               return false
            end

            def self.new_data(full_name)
               new_performer = self.find_initialized('full_name', full_name)
               if new_performer == false
                  new_performer = Performer.new(id: self.id, full_name: full_name)
                  self.insert_data(new_performer.attributes)
               end
               return new_performer
            end
         end

         class TicketConstant
            @@id = Ticket.last.id + 1
            @@datas = Array.new()
            def self.id; return @@id; end
            def self.add_id; @@id += 1; end
            def self.datas; return @@datas; end
            def self.insert_data(data)
               data.delete('created_at')
               data.delete('updated_at')
               @@datas << data
            end

            def self.new_data(grade, price)
               new_ticket = Ticket.new(id: self.id, event_id: SeedAttribute::EventConstant.id, grade: grade, price: price)
               self.insert_data(new_ticket.attributes)
               return new_ticket
            end
         end
      end

      class String
         def camelize
            self.split('_').map { |w| w[0] = w[0].upcase; w }.join
         end
      end

      include SeedAttribute

      agent = Mechanize.new
      tr_elements = agent.get('http://www.nohgaku.or.jp/playinginfo/index.html').search('#playing-table tr')
      # 先頭の要素がテーブルのヘッダーであるため不要
      tr_elements.shift
      tr_elements.each do |tr|
         #各要素を取り出してみる
         tds = tr.css('td')

         # 「・」から文字列が始まる演目はこのrakeでは処理できない(現状)では
         # なのでスルー
         next if !tds[3].children[0].text.match?(/[[:punct:]]/) || tds[4].children[0].text.match?(/料金未定/)

         place_title = tds[5].text # 会場名
         #あればソノレコードのid、なければ最後のレコードid + 1
         unless place_data = Place.find_by(title: place_title)
            place_data = PlaceConstant.new_data(place_title)
            PlaceConstant.add_id
         end
         event_title = tds[2].text.gsub(/\r|\n|\t/, '')
         event_data = EventConstant.new_data(tds[2].text, EventConstant.format_datetime(tds[0].text, tds[1].text), place_data)

         program_txts = Array.new()
         tds[3].children.each do |val|
            if val.class == Nokogiri::XML::Text
               break if val.text.match?(/ほか/)
               program_txts << val.text.gsub(/\r|\n|\t/, '')
            end
         end
         # programs Arrayは奇数idxをEventProgram、偶数idxをEventPerformerとして認識させて
         # ペアとして後に組み合わせるのでペアからあぶれた(余った)要素がある場合、
         # 必要のない要素だと認識
         program_txts.pop if program_txts.count % 2 == 1
         event_programs = Array.new()
         program_txts.each_with_index do |val, idx|
            if idx % 2 == 0
               words = val.split(/[[:blank:]|[:punct:]]/)
               unless program_data = Program.find_by("title LIKE '%#{words[2]}%'")
                  program_data = ProgramConstant.new_data(words[2])
                  ProgramConstant.add_id
               end
               event_program_data = EventProgramConstant.new_data(program_data.id, words[0])
            else
               words = val.split(/[[:blank:]]/)
               unless performer_data = Performer.find_by(full_name: words[1])
                  performer_data = PerformerConstant.new_data(words[1])
                  PerformerConstant.add_id
               end
               event_performer_data = EventPerformerConstant.new_data(performer_data.id)
               EventPerformerConstant.add_id
               EventProgramConstant.add_id
            end
         end

         ticket_txts = Array.new()
         tds[4].children.each do |val|
            if val.class == Nokogiri::XML::Text
               if val.text.match?(/[0-9]*,?[0-9]+円/)
                  ticket_val = val.text.gsub(/\r|\n|\t/, '').gsub(/^\(|\)$/, '')
                  ticket_val = "全席自由 #{ticket_val}" if ticket_val.match?(/^[0-9]*,?[0-9]+円/)
                  ticket_txts << ticket_val
               elsif val.text.match?(/無料/)
                  ticket_txts << '全席 0円'
               end
            end
         end

         ticket_txts.each do |val|
            val.insert(val.index(')') + 1, ' ') if val.match?(/\)/)
            words = val.gsub(/,|円.*|\s{2}/, '').split(/[[:blank:]]/)
            ticket_data = TicketConstant.new_data(words[0], words[-1].to_i)
            TicketConstant.add_id
         end
         EventConstant.add_id
      end

      json_attrs = {
         date: Date.today.strftime("%Y-%m-%d"),
         seeds: {
            events: EventConstant.datas,
            event_programs: EventProgramConstant.datas,
            event_performers: EventPerformerConstant.datas,
            tickets: TicketConstant.datas,
            places: PlaceConstant.datas,
            programs: ProgramConstant.datas,
            performers: PerformerConstant.datas
         }
      }
      new_seed = File.open("#{FILE_PATH}/scraped_datas/#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_scraped_data.json", 'w') do |file|
         file.puts(JSON.pretty_generate(json_attrs))
      end

      puts "\nscraping completed!\nnow new seed data file #{Time.zone.now.strftime('%Y%m%d%H%M%S')}_scraped_data.json has been saved.\n\n"

      sleep 2

      # Seedファイルにデータを新しく追加
      puts "\ntask is adding the datas to seed files..."

      env = Rails.env == 'development' ? 'development' : 'production'

      dir = Dir.open("#{FILE_PATH}/#{env}")
      dir.each do |filename|
         /[0-9]+(.+)\.rb/ =~ filename
         target_key = $1
         if json_attrs[:seeds].include?(:"#{target_key}")
            File.open("#{FILE_PATH}/#{env}/#{filename}", 'a') do |line|
               line.puts "\n"
               line.puts "# scraped seed data from #{Time.zone.now.strftime('%Y%m%d%H%M%S')}_scraped_data.json"
               line.puts "\n"

               json_attrs[:seeds][:"#{target_key}"].each do |data|
                  line.puts "#{target_key.camelize[0..-2]}.seed do |s|"
                  data.each do |key, value|
                     if value.class == String || value.class == ActiveSupport::TimeWithZone
                        line.puts "\ts.#{key}\t=\s'#{value}'"
                     elsif value.class == NilClass
                        line.puts "\ts.#{key}\t=\snil"
                     else
                        line.puts "\ts.#{key}\t=\s#{value}"
                     end
                  end
                  line.puts 'end'
                  line.puts "\n"
               end
            end
            puts "seed data :#{target_key} has been added."
            sleep 1
         end
      end
      puts "\ntask completed!\n\n"

      # bin/rails db:seed_fu
      Rake::Task['db:seed_fu'].invoke()
   end
end
