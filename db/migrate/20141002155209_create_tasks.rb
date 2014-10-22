class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.string :title
      t.string :description
      t.string :state
      t.datetime :estimated_time
      t.datetime :time_spent
      t.datetime :deadline
      t.timestamps
    end
  end
end
