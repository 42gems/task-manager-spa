object @user
attributes :id, :email, :first_name, :last_name

node(:image_url) do |user|
  user.image.url
end