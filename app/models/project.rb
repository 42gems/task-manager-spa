class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :members, through: :invites, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title
  validates_length_of :description, maximum: 255

  scope :is_public, -> { where private: false }

  def not_new_tasks
    {
      'In progress' => tasks.in_progress,
      'Done'        => tasks.done,
      'Approved'    => tasks.approved
    }
  end

  def select_members
    user_ids = Invite.where(project_id: id).pluck(:user_id) << owner.id
    User.where('id IN (?)', user_ids).pluck :email, :id
  end

  def select_users_for_invites
    user_ids = Invite.where(project_id: id).pluck(:user_id) << owner.id
    users = User.where.not('id IN (?)', user_ids)
  end
end
