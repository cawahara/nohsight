# frozen_string_literal: true

class PointRecord < ApplicationRecord
   belongs_to :user
   belongs_to :event

   validates :user_id,  presence: true
   validates :event_id, presence: true
   validates :action,   presence: true
   validates :point,    presence: true

   def self.create_original_point_record(event)
      event.create_point_record!(user_id: event.editor.id,
                                   action: "新しい公演情報「#{event.title}」を公開しました",
                                   point:   10)
   end

   def self.create_edition_point_record(event)
      event.create_point_record!(user_id: event.editor.id,
                                   action: "公演情報「#{event.title}」を更新しました",
                                   point:   1)
   end
end
