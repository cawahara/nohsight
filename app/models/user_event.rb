# frozen_string_literal: true

class UserEvent < ApplicationRecord
   belongs_to :user
   belongs_to :event

   validates :user_id,     presence: true
   validates :event_id,    presence: true
   validates :organizer,   inclusion: { in: [true, false] }

   def self.create_edition_user_event(event, original)
      unless original.users.exists?(event.editor.id)
         original.user_events.create!(user_id:   event.editor.id,
                                      organizer: false)
      end
   end
end
