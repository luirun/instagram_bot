class AddThumbnailUrlToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :thumbnail_url, :text
  end
end
