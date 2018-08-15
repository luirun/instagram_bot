class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :page_url
      t.text :url
      t.integer :likes_count
      t.text :description

      t.timestamps null: false
    end
  end
end
