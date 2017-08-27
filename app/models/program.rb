# frozen_string_literal: true

class Program < ApplicationRecord
   has_many    :event_programs, dependent: :destroy
   has_many    :events,         through:   :event_programs
   # REVIEW: Programレコードが消えた時の関連EventProgramの処置(同時に消すべきでしょうか？)

   validates   :title,  presence: true
   # REVIEW: 今後、shimaiカラムのクラスはenum対応のintegerに変えていきたいと考えています。
   # =>     ex. { なし: 0, クセ: 1, キリ: 2, それ以外: 3 }
end
