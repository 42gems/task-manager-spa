class User < ActiveRecord::Base
  include Authenticable
  has_many :tokens,     dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :timetracks, dependent: :nullify
  has_many :invites,    dependent: :nullify
  has_many :projects,   foreign_key: 'owner_id', dependent: :nullify
  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name
  mount_uploader :image, AvatarUploader

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }
  # TODO: replace 'search' with 'term' as search sounds like a method name.
  # also rename this method just to search by as it has nothing to do with invites alone.
  scope :filter_for_invites, -> (search) { where("email ilike :search or concat(first_name, ' ', last_name) ilike :search", search: "%#{search}%") }

  def pending_invites
    invites.pending.includes(:project)
  end

  def image_data=(value)
    return unless value.present?
    if value.is_a? String then
      base64_string = value.split('base64,')[1]
      self.image = CarrierStringIO.new(Base64.decode64(base64_string))
    else
      self.image = value
    end
  end

  def all_projects
    data = []
    data << self.projects
    data << self.invited_to_projects
    data << Project.is_public
    data.flatten.uniq
  end

  # TODO: replace with has_many invited_projects, trough: :invites ..
  def invited_to_projects
    project_ids = Invite.where(user_id: self.id).pluck :project_id
    Project.where(id: project_ids)
  end

end
