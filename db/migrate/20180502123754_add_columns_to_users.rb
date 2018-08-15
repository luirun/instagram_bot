class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :posts_count, :integer
    add_column :users, :followers_count, :integer
    add_column :users, :followings_count, :integer
    add_column :users, :latest_hashtags, :text
  end
end
