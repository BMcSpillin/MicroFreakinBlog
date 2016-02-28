require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "sqlite3"
require "rake"
require "sinatra/flash"
require "./models"

enable :sessions
set :database, "sqlite3:MFB.db"

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

get "/" do 
  session.clear
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
  @user = current_user
  erb :home
end

post "/home" do #this version once returned hashtag. others return nil.

  @posts = Post.where(current_user)

  if current_user
    if @user && params[:content] != nil
      Post.new(
        user_id: current_user,
        content: params[:content],
        timestamp: Time.now
      )
      # @post.save
    end
  end

    redirect "/home"

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
    flash[:alert] = "Check your freakin' credentials. Does your ish match?" #not popping up
  end
  
  erb :sign_up
end

get "/signout" do
  session[:user_id] = nil
  redirect "/"
end

get "/edit" do
  @posts = Post.all()
  @users = User.all()
  erb :edit
end


post "/edit" do
  @users = User.all()
  @posts = Post.all()

  if params[:password] == params[:ver_password]
  
    @users = User.update(
      email: params[:email],
      fname: params[:fname],
      lname: params[:lname],
      birthday: params[:birthday],
      station: params[:station],
      bio: params[:bio]
      )

      @users.find(session[:user_id]).save
      flash[:notice] = "Transfer complete"
      redirect "/home"

  else
    flash[:alert] = "Check your freakin' credentials. Does your ish match?" #not popping up
  end

  erb :edit
end

get "/mta-status" do 
  erb :mta_status
end