class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  scope :accepted, -> { where(accepted: true) }
  scope :pending,  -> { where(accepted: false) }
end
