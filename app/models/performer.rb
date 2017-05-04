class Performer < ApplicationRecord

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
