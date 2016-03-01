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

# def handle
#   @user.params[:handle]
# end

get "/" do 
  session.clear
  erb :index
end

post "/" do
  @user = User.where(handle: params[:username]).first

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/home"
  else
    redirect "/"
    flash[:alert]
  end

  erb :index
end

get "/home" do
  @user = current_user
  @posts = Post.all
  @title = "All Freakin' Posts"
  erb :home
end

# get "/home/#{@user.handle}" do

#   erb :home/"#{@user.handle}"
# end

#   if params[:friendSearch] == Users.all(:handle)
#     || params[:friendSearch] == Users.all(:fname)
#     || params[:friendSearch] == Users.all(:email)
#   erb :home/friend
# end

post "/home" do

  @posts = Post.where(current_user)

    if current_user && params[:content] != nil
      Post.create(
        user_id: current_user.id,
        content: params[:content],
        timestamp: Time.now
      )
      # session[:post_id] = @post.id
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

get "/edit" do
 @user = current_user
 # list = Dir.glob("./public/assets/*.*").map{|f| f.split("/").last}
  # render list here
  erb :edit
end

put "/home" do
  if params[:password] == params[:ver_password]
    @user = current_user

    @user.password = params[:password]
    @user.email = params[:email]
    @user.fname = params[:fname]
    @user.lname = params[:lname]
    @user.birthday = params[:birthday]
    @user.station = params[:station]
    @user.bio = params[:bio]

    @user.save
    redirect "/home"
  else
    flash[:alert] = "Confirm your freakin' password."
    redirect "/edit"
  end
end

delete "/:user_id" do |user|
  @user = current_user
  @user.destroy
  redirect "/"

  erb :edit
end

get "/mta-status" do
  @user = current_user
  erb :mta_status
end

# post "/upload" do
#   if params[:file] &&
#     (tmpfile = params[:file][:tempfile]) &&
#     (name = params[:file][:filename])
#     flash[:alert] = "No freakin' mug here."
#     erb :id
#   else
#     erb :id
#   end
#   directory = "assets/files"
#   path = File.join(directory, name)
#   File.open(path, "wb") { |f| f.write(tmpfile.read) }
# end

post "/upload" do
  tempfile = params[:image]
  filename = params[:image]
  File.copy("./public/assets/#{filename}")
  redirect '/edit'
  # erb :edit
end

get "/friendSearch" do
  @user = User.find_by_fname(params[:friendSearch])
  @user = User.find_by_handle(params[:friendSearch])
  @user = User.find_by_email(params[:friendsearch])

  @user = User.find(params[:id])

  redirect "/users/#{@user.id}"
  erb :friendSearch
end



