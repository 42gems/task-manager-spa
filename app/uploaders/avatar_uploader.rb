class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  resize_to_fit(50, 50)
end