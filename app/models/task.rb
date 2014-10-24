class Task < ActiveRecord::Base
  include AASM

  belongs_to :project
  has_many :comments, dependent: :destroy

  aasm column: :state do
    state :todo, initial: true
    state :in_progress
    state :done
    state :approved
  end

  validates :title, :state, presence: true
  scope :open, -> { where(state: [:todo, :in_progress]) }
end
