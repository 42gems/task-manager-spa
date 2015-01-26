class Timetrack < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many   :comments
  accepts_nested_attributes_for :comments
  after_create :increment_time_spent
  after_destroy :decrement_time_spent
  after_update :update_time_spent

  def increment_time_spent
  	task.time_spent += amount if amount
  	task.save
  end

  def decrement_time_spent
  	task.time_spent -= amount if amount
  	task.save
  end

  def update_time_spent
  	task.time_spent += amount - amount_was
  	task.save
  end
end
