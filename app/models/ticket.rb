class Ticket < ApplicationRecord
   belongs_to :event

   validates  :event_id,   presence: true
   validates  :grade,      presence: true
   validates  :price,      presence: true
end
