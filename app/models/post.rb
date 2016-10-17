class Post < ActiveRecord::Base
  
  
  belongs_to :user
  has_many :comments
  has_many :likes

  validates_presence_of :photo_url, :user 
  # validating that we not only have a :user_id, but that we 
  # actually have a User record with said id. Try with tux: need user_id:1
  
  def humanized_time_ago
    time_ago_in_seconds = Time.now - self.created_at 
    #equivalent to calling .created_at on the object itself
    time_ago_in_minutes = time_ago_in_seconds / 60
    
    time_ago_in_hours = time_ago_in_minutes / 60
    
    time_ago_in_days = time_ago_in_hours / 24
    
    time_ago_in_weeks = time_ago_in_days / 7
if time_ago_in_days >= 7
  "#{(time_ago_in_weeks).to_i} weeks ago"
elsif time_ago_in_hours >= 24
  "#{(time_ago_in_days).to_i} days ago"
elsif time_ago_in_minutes >= 60
  "#{(time_ago_in_hours).to_i} hours ago"
elsif time_ago_in_minutes <= 60
"#{(time_ago_in_minutes).to_i} minutes ago"
elsif time_ago_in_seconds <= 60
"#{(time_ago_in_minutes).to_i} <1 minute ago"
end

  end
  
  def like_count
    self.likes.size
  end
  
  def comment_count
    self.comments.size
  end
  
  
end