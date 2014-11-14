class User < ActiveRecord::Base
  include Authenticable
  has_many :invites,  dependent: :nullify
  has_many :projects, foreign_key: 'owner_id', dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :tokens,   dependent: :destroy

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }

  def invited_members
    #TODO avoid N+1 select. You can use includes for relation
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
end
