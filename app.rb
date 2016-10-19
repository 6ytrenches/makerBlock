require 'sinatra' 
require 'sinatra/activerecord'
require './models'
enable :sessions

set :database, "sqlite3:uncubed.sqlite3"

$menu = [

  {page: 'main', href: './generalPage'},
  {page: 'home', href: './home'}
  ]
  
get '/home' do 
# @regus = User.find_by(email: @user)
 erb :home
end



#-------------------------
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


get '/personal/:id' do 
  @users = User.find(params[:id])
  erb :personal
end

post '/home' do
  
  a = params["email"].to_s
  b = User.find_by(email: a)
  session[:user_id] = b.id

  @confirmation = b[:fname]
  @lname = b[:lname]
  @username = b[:username]
  @gender = b[:gender]
  @email = b[:email]
  
  # @user = @regus.email
  erb :personal
end



#-------------------------

get '/posts' do
  @posts = Post.all
  erb :generalPage
end

post '/posts' do 
  
  erb :generalPage
end

#-------------------------
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

