# frozen_string_literal: true

class Style < ApplicationRecord
   has_many :performers,   dependent: :destroy

   validates :title,       presence: true
end
