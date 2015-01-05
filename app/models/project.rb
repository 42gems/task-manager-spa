class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :tasks,   dependent: :destroy
  has_many :members,    through: :invites, source: :user
  has_many :timetracks, through: :tasks

  validates_presence_of :title
  validates_length_of :description, maximum: 255

  scope :is_public, -> { where private: false }

  def select_users_for_invites
    user_ids = Invite.where(project_id: id).pluck(:user_id) << owner.id
    User.where.not(id: user_ids)
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
end
