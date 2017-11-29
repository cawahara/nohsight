# frozen_string_literal: true

id = 1

20.times do |n|
   UserEvent.seed do |s|
      s.id = id
      s.user_id = 1
      s.event_id = id
   end
   id += 1
end
