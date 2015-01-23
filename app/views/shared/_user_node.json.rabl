attributes :id, :email, :first_name, :last_name
node(:full_name) { |user| "#{user.first_name} #{user.last_name}" }