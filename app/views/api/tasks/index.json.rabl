collection @tasks
attribute :created_at, :deadline, :description,
  :estimated_date, :estimated_time, :id, :project_id, :state,
  :time_spent, :title, :updated_at

child assignee: :assignee do
  extends "shared/user_node"
end
