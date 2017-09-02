# frozen_string_literal: true

class Ticket < ApplicationRecord
   belongs_to :event

   before_validation :chomp_currency

   validates  :event_id,   presence: true
   validates  :grade,      presence: true
   validates  :price,      presence: true

   def self.required_columns
      return ['event_id', 'grade', 'price']
   end

   private

   def chomp_currency
      if self.price =~ /([0-9])([^0-9])/
         self.price.to_s.gsub(/^[^0-9]*|[^0-9]*$/, "").to_i
      end
   end

end
