# encoding: utf-8

class FlyersUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

end
