UserEvent.delete_all
id_num = 1
event_id_num = 1
Event.all.each do |event|
   counter = rand(0..2)
   counter.times do |n|
      UserEvent.seed do |s|
         s.id =         id_num
         s.user_id =    rand(1..14)
         s.event_id =   event_id_num
      end
      id_num += 1
   end
   event_id_num += 1
end
