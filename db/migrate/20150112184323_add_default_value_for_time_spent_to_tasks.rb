class AddDefaultValueForTimeSpentToTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :time_spent, :integer, default: 0
  end
end
