class AddMyProfileIdToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :my_profile_id, :integer
  end
end
