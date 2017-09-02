# frozen_string_literal: true

class Event < ApplicationRecord
   belongs_to :place
   has_many   :event_programs,   dependent: :destroy
   has_many   :programs,         through:   :event_programs
   has_many   :tickets,          dependent: :destroy
   has_many   :user_events,      dependent: :destroy
   has_many   :users,            through:   :user_events

   before_validation :set_value_on_category

   validates :title, presence: true
   validates :place_id, presence: true,
                        on: :update_publish
   validates :start_date,  presence: true,
                           on: :update_publish
   validates :published,   inclusion: { in: [true, false] }
   validate  :open_date_earlier_than_start_date
   validates :category, inclusion: { in: ['能楽協会主催', '能楽堂主催', '能楽協会員出演', '教室、セミナー', 'その他'] }

   # TODO: イベント開催時、特定の項目を満たしていないとサイト上に公開できない仕様にする

   def open_date_earlier_than_start_date
      if open_date && open_date > start_date
         errors.add(:open_date, 'should be earlier than start_date')
      end
   end

   private

   def set_value_on_category
      self.category = 'その他' if category.nil?
   end
end
