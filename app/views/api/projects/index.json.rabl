collection @projects
attributes :id, :owner_id, :title, :description, :private

child owner: :owner do
  attributes :id, :email, :first_name, :last_name
end

node(:type)        { |project| project.type_for(current_user) }
node(:time_stats)  { |project| project.time_stats }
