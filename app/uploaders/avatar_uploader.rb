class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  resize_to_fit(32, 32)

  def default_url
  	"/img/default_avatar.png"
  end
end
