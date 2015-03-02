collection @invites
attribute :id, :user_id, :project_id, :accepted

child :project do
  attribute :id, :title, :description
end
