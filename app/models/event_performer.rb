# frozen_string_literal: true

class EventPerformer < ApplicationRecord
   belongs_to :event_program
   belongs_to :performer

   validates :event_program_id, presence: true
   validates :performer_id,     presence: true

   def self.required_columns
      return ['event_program_id', 'performer_id']
   end
end
