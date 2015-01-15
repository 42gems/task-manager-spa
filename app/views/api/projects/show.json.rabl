object @project
attributes :id, :owner_id, :title, :description, :private

child owner: :owner do
  attributes :id, :email, :first_name, :last_name
end
