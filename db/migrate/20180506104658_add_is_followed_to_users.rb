class AddIsFollowedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_followed, :boolean
  end
end
