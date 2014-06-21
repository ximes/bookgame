class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :introtext
      t.text :fulltext
      t.boolean :active
      t.boolean :death
      t.boolean :ending
      t.boolean :beginning
      t.references :book, index: true
      t.timestamps
    end
  end
end
