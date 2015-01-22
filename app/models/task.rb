class Task < ActiveRecord::Base
  include AASM

  belongs_to :project
  belongs_to :assignee, class_name: 'User'
  has_many :comments,   dependent: :destroy
  has_many :timetracks, dependent: :destroy

  aasm column: :state do
    state :todo, initial: true
    state :in_progress
    state :done
    state :approved
  end

  validates :title, :state, presence: true
  scope :open, -> { where(state: [:todo, :in_progress]) }
end
