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
    if id == project.owner.id || invites.where(project_id: project.id).any?
      true
    else
      false
    end
  end
end
