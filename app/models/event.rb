class Event < ApplicationRecord
   belongs_to :user
   belongs_to :place
   has_many   :event_programs,   dependent: :destroy
   has_many   :tickets,          dependent: :destroy

   validates :user_id,     presence: true
   validates :title,       presence: true
   validates :published,   presence: true

   # TODO: イベント開催時、特定の項目を満たしていないとサイト上に公開できない仕様にする
end
