# frozen_string_literal: true

class Performer < ApplicationRecord
   belongs_to  :style
   has_many    :event_performers,   dependent: :destroy
   # REVIEW: Performerレコードが消えた時の関連EventPerformerの処置(同時に消すべきでしょうか？)
   after_initialize :default_style, if: :new_record?

   HIRAGANA = /\A\p{Hiragana}+\z/u

   validates :full_name,      presence: true
   validates :last_name,      format:   { with: HIRAGANA },
                              allow_nil: true
   validates :first_name,     format:   { with: HIRAGANA },
                              allow_nil: true
   validates :style_id,       presence: true

   private

   def default_style
      self.style_id ||= 1
   end
end
