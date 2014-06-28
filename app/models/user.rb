class User < ActiveRecord::Base
  has_and_belongs_to_many :books

  acts_as_commentable
  
  enum role: {user: 0, vip: 1, admin: 2}

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
