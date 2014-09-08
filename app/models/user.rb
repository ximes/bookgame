class User < ActiveRecord::Base
  has_and_belongs_to_many :books

  acts_as_commentable
  
  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  has_attached_file :picture, :styles => { :hi_res => "1200x1200", :large => "600x600>", :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
