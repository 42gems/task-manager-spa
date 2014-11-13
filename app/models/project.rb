class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :members, through: :invites, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title
  validates_length_of :description, maximum: 255

  scope :is_public, -> { where private: false }

  #TODO I'm really shame to be a pain rearding naming. But "not new" === "old".
  #TODO do we use it anywhere at all ?
  def not_new_tasks
    {
      'In progress' => tasks.in_progress,
      'Done'        => tasks.done,
      'Approved'    => tasks.approved
    }
  end

  def select_members
    user_ids = Invite.where(project_id: id).pluck(:user_id) << owner.id
    #TODO we can avoid here plain SQL
    User.where('id IN (?)', user_ids).pluck :email, :id
  end

  def select_users_for_invites
    user_ids = Invite.where(project_id: id).pluck(:user_id) << owner.id
    #TODO we can avoid here plain SQL
    #TODO avoid not needed variables
    users = User.where.not('id IN (?)', user_ids)
  end
end
