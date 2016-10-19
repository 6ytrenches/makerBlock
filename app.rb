require 'sinatra' 
require 'sinatra/activerecord'
require 'paperclip'
require './models'
enable :sessions

set :database, "sqlite3:microblog.sqlite3"

$menu = [
  {page: 'Main', href: './generalPage'},
  {page: 'Home', href: './'},
  {page: 'Personal', href: './personal'},
  {page: 'Users', href: './all_users'}
  ]
#------------------------
#HOME PAGE  

get '/' do 
 erb :home
end

post '/' do
  
   b = User.find_by(email: params[:email]) 
   p b 
   p params
  if !b.nil? && params[:password] == b[:password].to_s
    session[:user_id] = b.id

  # @confirmation = b[:fname]
  # @lname = b[:lname]
  # @username = b[:username]
  # @gender = b[:gender]
  # @email = b[:email]
   
  redirect ('/personal')
  else 
    @error = 'Sorry you are not in our system'
    erb :home
  end
end

#-------------------------
#REGISTRATION PAGE 

get '/registration' do 
 
 erb :registration
end

post '/registration' do
  #if user is already in the system. also creating a new user
  @regus = User.create_with(locked: false).find_or_create_by(params)
  # @user = @regus.email
  erb :registration
end

#-------------------------
#PERSONAL PAGE

get '/personal' do 
  @users = User.all
  @user = User.find(session[:user_id])

  erb :personal
end

get '/personal/:id' do 
  @users = User.all
  # @user = User.find(session[:user_id])
  @user = User.find(params[:id])

  erb :personal
end


post '/personal' do 
  erb :personal
end

#-------------------------
#GENERAL PAGE WITH ALL POSTS

get '/generalPage' do
  
  erb :generalPage
end



post '/general' do 
  c = params["username"]
  d = User.find_by(username: c)
  e = d[:id].to_i
  Post.create(content: params["content"], user_id: e)
  @comment = Post.first.to_s
end


post '/generalPage' do 
  
  posts_user = User.find_by(username: params[:username])
  
  if !posts_user.nil? 
    e = posts_user[:id].to_i
    Post.create(content: params[:content], user_id: e)  
  erb :generalPage
  
  else 

    redirect ('/registration')
  
  end
end


#-------------------------
#UPDATE PERSONAL INFO PAGE 

get '/editpersonal' do

  @user = User.find(session[:user_id])
  @updated = @user[:fname]
erb :editpersonal
end


post '/editpersonal' do

  # @edited = User.create_with(locked: false).find_or_create_by(params)
  @user = User.find(session[:user_id])
  a = params["email"].to_s
  c = @user.update(fname: params[:fname])
  @confirmation = @user[:fname]
  u = @user.update(username: params[:username])
  @username  = @user[:username]
  l = @user.update(lname: params[:lname])
  @lname  = @user[:lname]
  e = @user.update(email: params[:email])
  @email = @user[:email]
  g = @user.update(gender: params[:gender])
  @gender = @user[:gender]

  erb :editpersonal
end


get "/delete_profile" do
  @user = User.find(session[:user_id])
  User.find(@user).destroy
  redirect "/home"
end
#------------------------------------------
#  ALL_USERS PAGE
get '/all_users' do


@users = User.all
erb :all_users
end
