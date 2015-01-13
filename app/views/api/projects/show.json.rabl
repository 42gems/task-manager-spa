object @project
attributes :id, :owner_id, :title, :description, :private

node(:owner_email) { |project| project.owner.email }
