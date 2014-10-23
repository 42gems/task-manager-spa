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

  #TODO 3 you'te too young to use OLD-SCHOOL validattions - read about validates presence: true , etc.
  validates_presence_of  :title, :state

  #changed values to keys
  validates_inclusion_of :state, in: STATES.keys.map(&:to_s), message: 'state can be only new/in progress/done/approved'

  #TODO 4 what about state: ["new", "in_progress"]
  scope :open, -> { where("state = ? OR state = ?", 'new', 'in progress') } #NOTICE don't tell me you're storing splitted words for state in DB :)

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
