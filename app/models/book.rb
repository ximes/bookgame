class Book < ActiveRecord::Base
	
	include Completable

	validates :title, :presence => true

	has_paper_trail

	acts_as_commentable

	has_and_belongs_to_many :users
	has_many :chapters

	accepts_nested_attributes_for :chapters

	has_attached_file :cover, :styles => { :hi_res => "1200x1200", :large => "600x600>", :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  	scope :publishable, -> { where(completed: true, publishable: true) }
  	
  	scope :owned_by, -> (user=nil) { joins(:users).where(users:{id: user.id}) }
  	scope :not_owned_by, -> (user=nil) { all - owned_by(user) }

	def completable?
		!chapters.map{|chapter|
			chapter.completable?
		}.include?(false) 
	end

	def complete!
		if completable?
			chapters.each{|chapter|
				chapter.complete!
			} 
			self.completed = true
			save! 
		end
	end

	def publish!
		self.publishable = true
		save!
	end

	def unpublish!
		self.publishable = false
		save!
	end
end
