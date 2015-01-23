object @project
attributes :id, :owner_id, :title, :description, :private

child owner: :owner do
  extends "shared/user_node"
end
