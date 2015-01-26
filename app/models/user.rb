class User < ActiveRecord::Base
  include Authenticable
  has_many :tokens,     dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :timetracks, dependent: :nullify
  has_many :invites,    dependent: :nullify
  has_many :projects,   foreign_key: 'owner_id', dependent: :nullify
  has_many :invited_projects, through: :invites, source: :project
  validates :email,     uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name
  mount_uploader :image, AvatarUploader

  scope :accepted_invite, -> { where(invites: { accepted: true }) }
  scope :pending_invite,  -> { where(invites: { accepted: false }) }
  scope :search_by_full_name_or_email, -> (search_string) { where("email ilike :value or concat(first_name, ' ', last_name) ilike :value", value: "%#{search_string}%") }
  scope :search_for_invite_to_project, -> (project, search_string) {
    invited_members_ids = project.invites.pluck(:user_id) << project.owner.id
    where.not(id: invited_members_ids).search_by_full_name_or_email(search_string).take 10
  }

  def pending_invites
    invites.pending.includes(:project)
  end

  def full_name
    "#{first_name} #{last_name}"
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
    data << self.invited_projects
    data << Project.public_only
    data.flatten.uniq
  end

end