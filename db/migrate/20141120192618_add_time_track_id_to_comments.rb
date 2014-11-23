class AddTimeTrackIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :timetrack_id, :integer
  end
end
