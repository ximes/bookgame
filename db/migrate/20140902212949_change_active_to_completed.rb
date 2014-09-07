class ChangeActiveToCompleted < ActiveRecord::Migration
  def change
	add_column :books, :completed, :boolean, :default => false
	remove_column :books, :active, :boolean, :default => false

	add_column :chapters, :completed, :boolean, :default => false
	remove_column :chapters, :active, :boolean, :default => false
  end
end
