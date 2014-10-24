class Task < ActiveRecord::Base
  include AASM

  belongs_to :project
  has_many :comments, dependent: :destroy

  def self.states_names(*names)
    names.map { |name| [name, I18n.t("states.#{name.to_s}")] }.to_h
  end

  STATES = states_names :todo, :in_progress, :done, :approved

  aasm column: :state do
    state :todo, initial: true
    STATES.keys[1..-1].each { |key| state key }
  end

  validates :title, :state, presence: true
  scope :open, -> { where(state: [:todo, :in_progress]) }
end
