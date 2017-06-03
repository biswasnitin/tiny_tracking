json.extract! user_track_log, :id, :user_id, :user_name, :created_at, :updated_at
json.url user_track_log_url(user_track_log, format: :json)
