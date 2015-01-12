class RemoveTimeSpentFromTasksAndRenameEstimatedTimeToEstimatedDate < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.remove :time_spent
      t.rename :estimated_time, :estimated_date
    end
  end
end
