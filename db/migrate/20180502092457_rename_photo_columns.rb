class RenamePhotoColumns < ActiveRecord::Migration[5.2]
  def change
  	rename_column :photos, :page_url, :page_id
  end
end
