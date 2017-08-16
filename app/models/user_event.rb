# frozen_string_literal: true

class UserEvent < ApplicationRecord
   belongs_to :user
   belongs_to :event

   validates :user_id,     presence: true
   validates :event_id,    presence: true
   validates :organizer,   inclusion: { in: [true, false]}
end
