class AddRelatedHashtagsToMyProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :my_profiles, :related_hashtags, :text
  end
end
