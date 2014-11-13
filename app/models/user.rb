class User < ActiveRecord::Base
  include Authenticable
  has_many :invites,  dependent: :nullify
  has_many :projects, foreign_key: 'owner_id', dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :tokens,   dependent: :destroy

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }

  #TODO invited what, who? Don't tell me 42
  def invited
    #TODO avoid N+1 select. You can use includes for relation
    projects.map do |project|
      { project: project, users: project.members.accepted_invite } if project.members.accepted_invite.any?
    #We have method for array named compact
    end.reject &:nil?
  end

  def pending_invites
    #TODO avoid N+1 select. You can use includes for relation
    invites.pending.map do |invite|
      {
        #TODO less letters - more hardcore.
        project: Project.find(invite.project_id),
        invite: invite
      }
    end
  end

  def all_projects
    data = []
    data << self.projects 
    data << Project.is_public
    data.flatten.uniq
  end
end
