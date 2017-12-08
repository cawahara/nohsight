class Comment < ApplicationRecord
   belongs_to :user,    optional: true
   belongs_to :event,   optional: true

   validates :user_id,  presence: true
   validates :event_id, presence: true
   validates :content,  presence: true
end
