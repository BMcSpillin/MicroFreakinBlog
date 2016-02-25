require "sinatra"
require "sinatra/activerecord"
require "sqlite3"
require "rake"
require "sinatra/flash"


get "/" do 
  
  erb  :index
end