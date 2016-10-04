class User < ActiveRecord::Base
    
  belongs_to :posts
  has_many :comments
  has_many :likes
  
  # validations methods. More here: "http://guides.rubyonrails.org/active_record_validations.html"
  validates_presence_of :email, :avatar_url, :username, :password  
  validates_uniqueness_of :email, :username
  
end