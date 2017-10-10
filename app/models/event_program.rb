# frozen_string_literal: true

class EventProgram < ApplicationRecord
   belongs_to :event
   belongs_to :program
   has_many   :event_performers, dependent: :destroy
   has_many   :performers,       through:   :event_performers

   attr_accessor :title

   validates :program_id,    presence: true
   # validates :event_id,      presence: true

   validates :genre,         presence: true
   # TODO: genreは「能、仕舞、歌舞伎」などの演芸の種類を入れるカラムです
   #       (styleと同じくアソシエートできれば変更します)

   def self.required_columns
      return ['event_id', 'program_id', 'genre']
   end
end
