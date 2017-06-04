class AddColumnToUserLog < ActiveRecord::Migration[5.1]
  def change
    add_column :user_track_logs, :is_late, :integer
  end
end
