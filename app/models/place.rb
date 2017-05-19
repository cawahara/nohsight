class Place < ApplicationRecord
   has_many :events,       dependent: :destroy
   has_many :programs,     dependent: :destroy
   # REVIEW Placeレコードが消えた時の関連Eventの処置(同時に消すべきでしょうか？)

   validates :address,     presence: true
   # TODO 能楽師サイドからリソースを得られ次第、内容に応じてカラムを追加(バリデーションも検討)
end
