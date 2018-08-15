json.extract! my_profile, :id, :url, :username, :password, :created_at, :updated_at
json.url my_profile_url(my_profile, format: :json)
