class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy

  after_initialize :set_state

  #TODO 1 move to aasm-state machine
  #TODO 2 use I18n for states translations
  STATES = {
    todo: 'new',
    in_progress: 'in progress',
    done: 'done',
    approved: 'approved'
  }

  validates :title, :state, presence: true
  validates :state, inclusion: { in: STATES.keys.map(&:to_s), message: 'state can be only new/in_progress/done/approved' }

  scope :open, -> { where("state IN (?)", ['new', 'in_progress']) }

  #TODO 5 see TODO 1
  STATES.each do |key, val|
    scope key, -> { where state: val }
  end

  #TODO what about persisted?
  private
  def set_state
    update_attributes state: 'new' if id.nil?
  end
end
