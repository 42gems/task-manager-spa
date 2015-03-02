collection @timetracks
attributes :id, :amount, :updated_at

child :user do
  extends "shared/user_node"
end

child :task do
  attribute :title
end