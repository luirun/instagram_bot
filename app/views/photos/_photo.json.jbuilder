json.extract! photo, :id, :page_url, :url, :likes_count, :description, :created_at, :updated_at
json.url photo_url(photo, format: :json)
