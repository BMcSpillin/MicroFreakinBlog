class User < ActiveRecord::Base
  has_many :posts
  before_update :destroy_current_user

  def destroy_current_user
    
  end
end



class Post < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
end