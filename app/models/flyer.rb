# frozen_string_literal: true

class Flyer < ApplicationRecord
   require 'carrierwave/orm/activerecord'
   belongs_to :event
   mount_uploader :image, FlyersUploader

   EXTENSIONS = /.*\.(jpg|jpeg|gif|png)/

   def valid_extension?
      self.image.url.match?(EXTENSIONS)
   end
end
