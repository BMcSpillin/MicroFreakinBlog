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
  erb :index
end

post "/" do
  @user = User.where(handle: params[:username]).first

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/home"
  end

  # @user.save
  erb :index
end



get "/home" do

  @user = current_user
  erb :home
end

post "/home" do
  if params[:content] != nil
    @post = Post.new(
    content: params[:content],
    user_id: current_user[:id]
    )
    @post.save
  end

  erb :home
end

post "/home" do

@post = Post.where(current_user)

  if current_user
    if @user && params[:content] != nil
      @post = Post.new(params[:content])

      newPost = @post.save
    end
  
  end  
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

get "/home" do
  erb :home
end

post "/home" do
  if params[:content] != nil
    @post = Post.new(
    content: params[:content],
    user_id: current_user[:id]
    )
    @post.save
  end

  erb :home
end