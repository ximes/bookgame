class AddSettingsToBooks < ActiveRecord::Migration
  def change
 	add_column :books, :introtext, :text
 	add_column :books, :page_format, :string
 	add_column :books, :font_name, :string
 	add_column :books, :font_google, :boolean
 	add_column :books, :font_google_name, :string
 	add_column :books, :credits, :text
  end
end
