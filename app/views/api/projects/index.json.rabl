collection @projects
attributes :id, :owner_id, :title, :description, :private

child owner: :owner do
  extends "shared/user_node"
end

node(:type)        { |project| project.type_for(current_user) }
node(:time_stats)  { |project| project.time_stats }
