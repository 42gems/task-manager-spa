class AddEstimatedTimeAndEstimatedTimeToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.integer :estimated_time
      t.integer :time_spent
    end
  end
end
