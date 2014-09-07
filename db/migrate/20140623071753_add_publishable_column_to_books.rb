class AddPublishableColumnToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :publishable, :boolean, :default => false
  end
end
