class CreateChapterships < ActiveRecord::Migration
  def change
    create_table :chapterships do |t|
    	t.references :chapter, index: true
    	t.references :parent, index: true
    end
  end
end
