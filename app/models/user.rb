class User < ActiveRecord::Base
    
    belongs_to :posts
    has_many :comments
    has_many :likes
    
end