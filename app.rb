require 'sinatra' 
require 'sinatra/activerecord'
require './models'
enable :sessions

set :database, "sqlite3:uncubed.sqlite3"

$menu = [

  {page: 'main', href: './generalPage'},
  {page: 'home', href: './home'},
  {page: 'personal', href: './profile'}
  ]
  
get '/home' do 
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

get '/general' do
  erb :generalPage
end


post '/general' do 
  c = params["username"]
  d = User.find_by(username: c)
  e = d[:id].to_i
  Post.create(id: e, content: params["content"])
  @comment = Post.first.to_s
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


get "/delete_profile" do
  @user = User.find(session[:user_id])
  User.find(@user).destroy
  redirect "/home"
end
#------------------------------------------

get '/all_users' do
@users = User.all
erb :all_users
end
