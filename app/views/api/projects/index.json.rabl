collection @projects
attributes :id, :owner_id, :title, :description, :created_at, :updated_at, :private

node(:type)        { |project| project.type_for(current_user) }
node(:owner_email) { |project| project.owner.email }
node(:time_stats)  { |project| project.time_stats }
