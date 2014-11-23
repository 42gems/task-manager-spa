class AddStartDateToTimetracks < ActiveRecord::Migration
  def change
    add_column :timetracks, :start_date, :datetime
  end
end
