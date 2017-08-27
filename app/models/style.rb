# frozen_string_literal: true

class Style < ApplicationRecord
   has_many :performers,   dependent: :destroy

   validates :title,       presence: true

   def role
      self.title.match(/.*方/)[0]
   end
end
