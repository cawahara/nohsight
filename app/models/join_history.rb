# frozen_string_literal: true

class JoinHistory < ApplicationRecord
   belongs_to :user,         optional: true
   belongs_to :event,        optional: true
   belongs_to :join_users,   class_name: 'User', foreign_key: 'user_id'
   belongs_to :join_events,  class_name: 'Event', foreign_key: 'event_id'

   STATUS = ['参加予定', '参加済']

   validates :user_id,     presence: true
   validates :event_id,    presence: true
   validates :status,      inclusion: { in: [0, 1] }
   validate  :has_already_recorded

   def has_already_recorded
      if JoinHistory.find_by(user_id: self.user_id, event_id: self.event_id)
         errors.add(:event_id, 'has already been recorded')
      end
   end
end
