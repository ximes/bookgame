class Book < ActiveRecord::Base
	
	validates :title, :presence => true

	has_paper_trail

	has_and_belongs_to_many :users
	has_many :chapters

	accepts_nested_attributes_for :chapters

	has_attached_file :cover, :styles => { :hi_res => "1200x1200", :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
end
