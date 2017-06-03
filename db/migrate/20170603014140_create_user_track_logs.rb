class CreateUserTrackLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_track_logs do |t|
      t.integer :user_id
      t.string :user_name

      t.timestamps
    end
  end
end
