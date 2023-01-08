json.extract! user, :id, :created_at, :updated_at, :name
json.url surveyor_url(user, format: :json)
