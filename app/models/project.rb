class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :tasks,   dependent: :destroy
  has_many :members,    through: :invites, source: :user
  has_many :timetracks, through: :tasks

  validates_presence_of :title
  validates_length_of :description, maximum: 255

  scope :is_public, -> { where private: false }

  def select_users_for_invites(search)
    invited_members_ids = invites.pluck(:user_id) << owner.id
    users = User.where.not(id: invited_members_ids)
    users = users.filter_for_invites search if search
    users.take 10
  end

  def type_for(user)
    if owner == user
      'owner'
    elsif members.include? user
      'member'
    elsif !private?
      'public'
    end
  end

  def members_with_owner
    [self.owner] + members.accepted_invite
  end

  def time_spent
    tasks.open.sum(:time_spent)
  end

  def time_spent_all
    tasks.sum(:time_spent)
  end

  def time_left
    estimated_time > time_spent ? estimated_time - time_spent : 0
  end

  def estimated_time
    tasks.open.sum(:estimated_time)
  end

  def time_stats
    {
      time_spent: time_spent_all,
      time_left:  time_left
    }
  end
end
