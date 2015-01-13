class User < ActiveRecord::Base
  include Authenticable
  has_many :tokens,     dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :timetracks, dependent: :nullify
  has_many :invites,    dependent: :nullify
  has_many :projects,   foreign_key: 'owner_id', dependent: :nullify
  validates :password, presence: true, confirmation: true, length: { in: 8..20 }
  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }

  def pending_invites
    invites.pending.includes(:project)
  end

  def all_projects
    data = []
    data << self.projects
    data << self.invited_to_projects
    data << Project.is_public
    data.flatten.uniq
  end

  def invited_to_projects
    project_ids = Invite.where(user_id: self.id).pluck :project_id
    Project.where(id: project_ids)
  end

end