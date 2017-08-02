# frozen_string_literal: true

EventProgram.delete_all

styles = ['観世流', '金剛流', '大蔵流']
genres = ['能', '狂言', '舞囃子']

id_num = 1
event_id_num = 1
Event.all.each do |_event|
   timer = rand(1..3) + 1
   timer.times do |_n|
      EventProgram.seed do |s|
         s.id = id_num
         s.event_id = event_id_num
         s.program_id = rand(1..209)
         s.style = styles[rand(0..2)]
         s.genre = genres[rand(0..2)]
      end
      id_num += 1
   end
   event_id_num += 1
end
