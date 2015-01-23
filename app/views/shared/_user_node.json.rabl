attributes :id, :email, :first_name, :last_name, :image_url
node(:full_name) { |user| "#{user.first_name} #{user.last_name}" }