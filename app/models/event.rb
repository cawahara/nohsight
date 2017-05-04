class Event < ApplicationRecord
   belongs_to :user
   has_many   :event_programs,   dependent: :destroy

   # validates :place_id,    presence: true
   validates :user_id,     presence: true
   validates :title,       presence: true
   validates :start_date,  presence: true
end
