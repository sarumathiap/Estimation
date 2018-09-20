json.extract! user, :id, :uid, :name, :email, :oauth_token, :oauth_expires_at, :role, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
