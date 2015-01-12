class FixTimeSpentDataFromTasks < ActiveRecord::Migration
  def up
    tasks_with_value = Task.all.reject { |task| task.time_spent.nil? }
    tasks_with_value.each { |task| task.timetracks.pluck(:amount).compact.reduce(:+) }
    
    nil_tasks = Task.all.reject { |task| task.time_spent }
    nil_tasks.each do |task|
      task.time_spent = 0
      task.save
    end
  end

  def down
    Task.where(time_spent: 0).each do |task| 
      task.time_spent = nil
      task.save
    end
  end
end
