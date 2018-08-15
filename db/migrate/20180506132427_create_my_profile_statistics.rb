class CreateMyProfileStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :my_profile_statistics do |t|
      t.integer :profile_id
      t.integer :posts_count
      t.integer :followers_count
      t.integer :followings_count

      t.timestamps
    end
  end
end
