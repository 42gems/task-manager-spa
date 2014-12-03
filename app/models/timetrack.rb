class Timetrack < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many   :comments
  accepts_nested_attributes_for :comments
end
