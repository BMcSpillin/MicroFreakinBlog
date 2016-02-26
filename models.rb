class User < ActiveRecord::Base
  has_many :posts
  
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end



class Post < ActiveRecord::Base
  belongs_to :user
end