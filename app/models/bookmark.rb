# frozen_string_literal: true

class Bookmark < ApplicationRecord
   belongs_to :bookmark_users,   class_name: 'User', foreign_key: 'user_id'
   belongs_to :bookmark_events,  class_name: 'Event', foreign_key: 'event_id'

   validates :user_id,  presence: true
   validates :event_id, presence: true
   validate  :has_already_bookmarked

   def has_already_bookmarked
      if Bookmark.find_by(user_id: self.user_id, event_id: self.event_id)
         errors.add(event_id: 'has already been bookmarked')
      end
   end
end
