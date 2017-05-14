class Performer < ApplicationRecord
   belongs_to  :style
   has_many    :event_performers,   dependent: :destroy
   # REVIEW Performerレコードが消えた時の関連EventPerformerの処置(同時に消すべきでしょうか？)

   HIRAGANA = /\A\p{Hiragana}+\z/u

   validates :full_name,      presence: true
   validates :last_name,      presence: true,
                              format:   { with: HIRAGANA }
   validates :first_name,     presence: true,
                              format:   { with: HIRAGANA }
   validates :style,          presence: true
   # REVIEW styleは流派カラムです(classという名前でカラムを定義するとNoMethodErrorに引っかかって
   #        インスタンスが作成できないです)
end
