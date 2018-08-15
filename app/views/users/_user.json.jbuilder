json.extract! user, :id, :profile_url, :like_count, :comment_count, :created_at, :updated_at
json.url user_url(user, format: :json)
