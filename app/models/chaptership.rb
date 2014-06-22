class Chaptership < ActiveRecord::Base
  belongs_to :chapter, :class_name => 'Chapter'
  belongs_to :parent, :class_name => 'Chapter'

  validates_uniqueness_of :chapter_id, scope: :parent_id
end