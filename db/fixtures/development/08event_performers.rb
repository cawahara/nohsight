# frozen_string_literal: true
EventPerformer.delete_all

id_num = 1
ev_program_id_num = 1
EventProgram.all.each do |event|
   timer = rand(1..3)
   timer.times do |n|
      EventPerformer.seed do |s|
         s.id = id_num
         s.event_program_id = rand(1..146)
         s.performer_id = rand(1..146)
      end
      id_num += 1
   end
   ev_program_id_num += 1
end
