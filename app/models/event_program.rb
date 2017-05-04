class EventProgram < ApplicationRecord
   belongs_to :event

   # validates :program_id,    presence: true
   validates :event_id,    presence: true
   validates :style,       presence: true
      # TODO   styleは流儀カラムですが、Classモデルとリレーションをかけられれば
      # =>     アソシエートできるようにしようと考えております
   validates :genre,       presence: true
      # TODO   genreは「能、仕舞、歌舞伎」などの演芸の種類を入れるカラムです
      # =>     (styleと同じくアソシエートできれば変更します)
end
