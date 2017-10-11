# frozen_string_literal: true

class PointRecord < ApplicationRecord
   belongs_to :user
   belongs_to :event

   validates :user_id,  presence: true
   validates :event_id, presence: true
   validates :action,   presence: true
   validates :point,    presence: true
end
