class User < ActiveRecord::Base
  include Authenticable
  has_many :invites,  dependent: :nullify
  has_many :projects, foreign_key: 'owner_id', dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :tokens,   dependent: :destroy

  def self.select_all_emails
    User.pluck :email, :id
  end

  def can_manage?(project)
    id == project.owner.id || invites.where(project_id: project.id).any?
  end

  def invited
    project_ids = projects.pluck :id
    user_ids = project_ids.map do |id|
      Invite.where(project_id: id).pluck :user_id
    end.flatten.uniq

    User.where id: user_ids
  end
end
