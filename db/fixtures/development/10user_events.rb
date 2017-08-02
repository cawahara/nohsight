# frozen_string_literal: true

UserEvent.delete_all
id_num = 1
event_id_num = 1
Event.all.each do |_event|
   organizer_id = rand(1..14)
   UserEvent.seed do |s|
      s.id =         id_num
      s.user_id =    organizer_id
      s.event_id =   event_id_num
      s.organizer =  true
   end
   id_num += 1
   counter = rand(0..2)
   counter.times do |_n|
      user_id_num = rand(1..14)
      user_id_num = rand(1..14) while user_id_num == organizer_id

      UserEvent.seed do |s|
         s.id =         id_num
         s.user_id =    user_id_num
         s.event_id =   event_id_num
         s.organizer =  false
      end
      id_num += 1
   end
   event_id_num += 1
end
