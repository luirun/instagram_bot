json.extract! profile_comment, :id, :profile_id, :content, :related_hashtags, :created_at, :updated_at
json.url profile_comment_url(profile_comment, format: :json)
