require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "sqlite3"
require "rake"
require "sinatra/flash"


get "/" do 
  
  erb  :index
end