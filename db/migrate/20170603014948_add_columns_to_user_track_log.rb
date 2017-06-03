class AddColumnsToUserTrackLog < ActiveRecord::Migration[5.1]
  def change
   add_column :user_track_logs, :arrival_time, :datetime
   
  end
end