json.extract! page, :id, :page_url, :followers_count, :following_count, :posts_count, :created_at, :updated_at
json.url page_url(page, format: :json)
