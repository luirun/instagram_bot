class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.text :page_url
      t.integer :followers_count
      t.integer :followings_count
      t.integer :posts_count

      t.timestamps null: false
    end
  end
end
