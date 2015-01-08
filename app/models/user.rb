class User < ActiveRecord::Base
  include Authenticable
  has_many :tokens,     dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :timetracks, dependent: :nullify
  has_many :invites,    dependent: :nullify
  has_many :projects,   foreign_key: 'owner_id', dependent: :nullify

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }

  def invited_members
    projects.map do |project|
      { project: project, users: project.members.accepted_invite } if project.members.accepted_invite.any?
    end.compact
  end

  def pending_invites
    invites.pending.includes(:project).map do |invite|
      { project: invite.project, invite: invite }
    end
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

  def all_projects_json
    all_projects.map do |project|
      project.as_json.merge({ type: project.type_for(self), owner_email: project.owner.email })
    end
  end

end