require 'sinatra' 
require 'sinatra/activerecord'
require './models'

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

  @confirmation = b[:fname]
  @lname = b[:lname]
  @username = b[:username]
  @gender = b[:gender]
  @email = b[:email]
  
  # @user = @regus.email
  erb :personal
end

# get '/company/:id' do 
#   @company = Company.find(params[:id])
#   erb :company_profile
# end

# ------------------------


get '/user/:id' do 
  @user = User.find(params[:id])
  erb :personal
end

post '/user' do
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

