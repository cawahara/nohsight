# frozen_string_literal: true

class PointRecord < ApplicationRecord
   belongs_to :user

   validates :user_id,  presence: true
   validates :action,   presence: true
   validates :point,    presence: true
end
