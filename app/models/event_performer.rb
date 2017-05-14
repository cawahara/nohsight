class EventPerformer < ApplicationRecord
   belongs_to :event_program
   belongs_to :performer

   validates :event_program_id, presence: true
   validates :performer_id,     presence: true
end
