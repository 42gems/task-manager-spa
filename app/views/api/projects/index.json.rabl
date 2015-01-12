collection @projects
attributes :id, :owner_id, :title, :description, :created_at, :updated_at, :private

node(:type) { |project| project.type_for('123') }

node(:owner_email) { |project| project.owner.email }