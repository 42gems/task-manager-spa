class User < ActiveRecord::Base
  include Authenticable
  has_many :invites,  dependent: :nullify
  has_many :projects, foreign_key: 'owner_id', dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :tokens,   dependent: :destroy

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }

  def self.select_all_emails
    User.pluck :email, :id
  end

  def can_manage?(project)
    id == project.owner.id || invites.where(project_id: project.id).any?
  end

  def invited
    projects.map do |project|
      { project: project, users: project.members.accepted_invite } if project.members.accepted_invite.any?
    end.reject &:nil?
  end

  def pending_invites
    invites.pending.map do |invite|
      { 
        project: Project.find(invite.project_id),
        invite: invite
      }
    end
  end

  def participant_in
    project_ids = self.project_ids << self.invites.accepted.pluck(:project_id)
    project_ids.flatten!
    Project.where 'id IN (?)', project_ids
  end
end
