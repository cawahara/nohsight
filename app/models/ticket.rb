# frozen_string_literal: true

class Ticket < ApplicationRecord
   belongs_to :event

   validates  :event_id,   presence: true
   validates  :grade,      presence: true
   validates  :price,      presence: true

   def self.required_columns
      return ['event_id', 'grade', 'price']
   end
end
