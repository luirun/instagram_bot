class RenamePageColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :pages, :page_url, :url
  end
end
