class CreateMyProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :my_profiles do |t|
      t.text :url
      t.text :username
      t.text :password

      t.timestamps
    end
  end
end
