json.extract! my_profile_statistic, :id, :profile_id, :post_count, :followers_count, :followings_count, :created_at, :updated_at
json.url my_profile_statistic_url(my_profile_statistic, format: :json)
