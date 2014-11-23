class CreateTimetracks < ActiveRecord::Migration
  def change
    create_table :timetracks do |t|
      t.integer :task_id
      t.integer :amount
      t.timestamps
    end
  end
end
