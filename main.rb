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

get "/sign-up" do
  erb :sign_up
end