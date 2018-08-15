class CreateProfileComments < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_comments do |t|
      t.integer :profile_id
      t.text :content
      t.text :related_hashtags

      t.timestamps
    end
  end
end
