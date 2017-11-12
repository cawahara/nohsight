# frozen_string_literal: true

class FlyersUploader < CarrierWave::Uploader::Base
   include CarrierWave::RMagick
   if Rails.env.production?
      include Cloudinary::CarrierWave
   else
      storage :file
   end

   def store_dir
      "uploads/#{model.class.to_s.underscore}/#{model.id}"
   end

   def public_id
      return model.id
   end

   def extension_white_list
      %w(jpg jpeg gif png)
   end

end
