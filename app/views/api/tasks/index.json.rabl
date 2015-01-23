collection @tasks
attribute :created_at, :deadline, :description,
  :estimated_date, :estimated_time, :id, :project_id, :state,
  :time_spent, :title, :updated_at

# TODO: use new style for hashes: { key: :value }
child :assignee => :assignee do
  attributes :id, :email, :first_name, :last_name, :image_url
end
