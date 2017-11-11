# frozen_string_literal: true

class Event < ApplicationRecord
   belongs_to :place
   has_many   :event_programs,   dependent: :destroy
   has_many   :programs,         through:   :event_programs
   has_many   :tickets,          dependent: :destroy
   has_many   :user_events,      dependent: :destroy
   has_many   :users,            through:   :user_events
   has_many   :bookmarks,        dependent: :destroy
   has_many   :bookmark_users,   class_name: 'User',
                                 foreign_key: 'user_id',
                                 through:    :bookmarks
   has_one    :comment,          dependent: :destroy
   has_one    :point_record,     dependent: :destroy

   has_many   :editions,         class_name: 'Event',
                                 foreign_key: 'original_event_id',
                                 dependent:  :destroy
   belongs_to :original,         class_name: 'Event',
                                 foreign_key: 'original_event_id'

   before_validation :set_value_on_category

   VALID_URL_REGEX = /\Ahttps?:\/\/.*/
   CATEGORIES = ['本公演', 'イベント', 'セミナー・教室', '社中会', 'その他']
   PUBLISHING_STATUS = ['下書き', '承認中', '却下', '公開', '訂正']

   validates :title,                presence: true
   validates :place_id,             presence: true
   validate  :open_date_earlier_than_start_date
   validates :start_date,           presence: true
   validates :official_url,         presence: true,
                                    format: { with: VALID_URL_REGEX }
   validates :category,             inclusion: { in: [0, 1, 2, 3, 4] }
   validates :publishing_status,    inclusion: { in: [0, 1, 2, 3, 4] }

   # validations
   def open_date_earlier_than_start_date
      if start_date
         if open_date && open_date > start_date
            errors.add(:open_date, 'should be earlier than start_date')
         end
      else
         if open_date
            errors.add(:open_date, 'should be valid after start_date is defined')
         end
      end
   end

   def has_event_program?
      return event_programs.count > 0 ? true : false
   end

   def has_event_performer?
      if event_programs.count > 0
         event_programs.each do |event_program|
            return event_program.event_performers.count > 0 ? true : false
         end
      else
         return false
      end
   end

   def has_ticket?
      return tickets.count > 0 ? true : false
   end

   # 特殊アソシエーション用
   def editor
      self.users.first
   end

   def approve_original_event
      PointRecord.create_original_point_record(self)
      self.update_attributes!(publishing_status: 3)
   end

   def approve_edition_event
      PointRecord.create_edition_point_record(self)
      UserEvent.create_edition_user_event(self, self.original)
      self.update_attributes!(publishing_status: 4)
   end

   # view用helper
   def current_publishing_status
      return PUBLISHING_STATUS[self.publishing_status]
   end

   def category_name
      return CATEGORIES[self.category]
   end

   def is_original?
      return self.original.nil?
   end

   def set_value_on_category
      self.category = 0 if self.category.nil?
   end
end
