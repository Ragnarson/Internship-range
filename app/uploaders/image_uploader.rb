require 'carrierwave/processing/mini_magick'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process resize_to_limit: [200,300]
  version :thumb do
    process resize_to_fill: [48, 48]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
