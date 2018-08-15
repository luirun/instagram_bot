class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :profile_url
      t.integer :like_count
      t.integer :comments_count

      t.timestamps null: false
    end
  end
end
