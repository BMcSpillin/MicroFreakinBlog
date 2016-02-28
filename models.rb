class User < ActiveRecord::Base
  has_many :posts
end



class Post < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
end