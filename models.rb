class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
end

# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database =>  'sinatra_application.sqlite3.db'
# )