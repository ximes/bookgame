class AddPositionToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :position, :integer
  end
end
