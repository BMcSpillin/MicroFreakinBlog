require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "sqlite3"
require "rake"
require "sinatra/flash"

set :database, "sqlite3:MFB.db"


get "/" do 
  
  erb  :index
end

get "/" do
  @users = User.current
  erb :home
end

get "/home" do
  @post = Post.new()
  erb :home
end

get "/" do
end
