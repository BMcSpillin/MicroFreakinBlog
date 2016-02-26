require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "sqlite3"
require "rake"
require "sinatra/flash"
require "./models"

set :database, "sqlite3:MFB.db"

get "/" do  
  erb :index
end

post "/" do
  @user = User.where(handle: params[:username]).first

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/home"
  end

  erb :index
end

get "/home" do
  erb :home
end

get "/sign-up" do
  erb :sign_up
end

post "/sign-up" do
  if params[:password] == params[:ver_password]
  
    @user = User.create(
      handle: params[:username],
      password: params[:password],
      email: params[:email],
      fname: params[:fname],
      lname: params[:lname],
      birthday: params[:birthday],
      station: params[:station],
      bio: params[:bio]
      )

      @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You're freakin' in!"
      redirect "/home"

    else
      flash[:alert] = "Check your freakin' credentials. Does your ish match?"
    end
      erb :sign_up
end
