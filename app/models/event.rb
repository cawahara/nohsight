# frozen_string_literal: true

class Event < ApplicationRecord
   belongs_to :place
   has_many   :event_programs,   dependent: :destroy
   has_many   :programs,         through:   :event_programs
   has_many   :tickets,          dependent: :destroy
   has_many   :user_events,      dependent: :destroy
   has_many   :users,            through:   :user_events
   has_one    :comment,          dependent: :destroy

   before_validation :set_value_on_category

   VALID_URL_REGEX = /\Ahttps?:\/\/.*/
   PUBLISHING_STATUS = ['draft', 'requested', 'rejected', 'published', 'merged']

   validates :title, presence: true
   validates :place_id, presence: true,
                        on: :update_publish
   validate  :open_date_earlier_than_start_date
   validates :start_date,  presence: true,
                           on: :update_publish
   validates :official_url, presence: true,
                            format: { with: VALID_URL_REGEX },
                            on: :update_publish
   validates :category, inclusion: { in: ['能楽協会主催', '能楽堂主催', '能楽協会員出演', '教室、セミナー', 'その他'] }
   validates :publishing_status, inclusion: { in: [0, 1, 2, 3, 4] }
   validate  :own_event_program,
              on: :update_publish
   validate  :own_event_performer,
              on: :update_publish
   validate  :own_ticket,
              on: :update_publish

   def open_date_earlier_than_start_date
      if start_date
         if open_date && open_date > start_date
            errors.add(:open_date, 'should be earlier than start_date')
         end
      else
         errors.add(:open_date, 'should be valid after start_date is defined')
      end
   end

   def own_event_program
      if event_programs.count == 0
         errors.add(:event_programs, 'should have at least one event_program')
      end
   end

   def own_event_performer
      if event_programs.count > 0
         event_programs.each do |event_program|
            if event_program.event_performers.count == 0
               errors.add(:event_performers, 'should have at least one event_performer in each event_program')
            end
         end
      end
   end

   def own_ticket
      if tickets.count == 0
         errors.add(:tickets, 'should have at least one ticket')
      end
   end

   private

   def set_value_on_category
      self.category = 'その他' if category.nil?
   end
end
