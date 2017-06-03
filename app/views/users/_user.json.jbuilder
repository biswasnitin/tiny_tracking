json.extract! user, :id, :code, :name, :created_at, :updated_at
json.url user_url(user, format: :json)
