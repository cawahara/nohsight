# frozen_string_literal: true

id = 12

20.times do |n|
   UserEvent.seed do |s|
      s.id = id
      s.user_id = 12
      s.event_id = id
   end
   id += 10
end
