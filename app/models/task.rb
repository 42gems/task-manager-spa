class Task < ActiveRecord::Base
  include AASM

  belongs_to :project
  has_many :comments, dependent: :destroy

  STATES = {
    todo:        I18n.t('states.todo'),
    in_progress: I18n.t('states.in_progress'),
    done:        I18n.t('states.done'),
    approved:    I18n.t('states.approved')
  }

  aasm column: :state do
    state :todo, initial: true
    STATES.keys[1..-1].each { |key| state key }
  end

  validates :title, :state, presence: true
  scope :open, -> { where("state IN (?)", ['todo', 'in_progress']) }
end
