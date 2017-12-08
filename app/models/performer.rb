# frozen_string_literal: true

class Performer < ApplicationRecord

   belongs_to  :style,              optional: true
   has_many    :event_performers,   dependent: :destroy
   has_many    :event_programs,     through:   :event_performers
   # REVIEW: Performerレコードが消えた時の関連EventPerformerの処置(同時に消すべきでしょうか？)

   HIRAGANA = /\A\p{Hiragana}+\z/u

   validates :full_name,      presence: true
   validates :last_name,      format:   { with: HIRAGANA },
                              allow_nil: true
   validates :first_name,     format:   { with: HIRAGANA },
                              allow_nil: true
end
