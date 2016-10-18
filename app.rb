require 'sinatra' 
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:uncubed.sqlite3"

$menu = [
  {page: 'home', href: '/home'},
  {page: 'main', href: '/generalPage'},
  {page: 'profile', href: '/personal'}
  ]
  
  get '/' do 
  @users = User.all
  erb :home
end


 get '/home' do 
  @regus = User.find_by(email: @user)
 erb :home
end



post '/home' do
  # a = params["bob"].to_s
  @regus = User.create(params)
  @user = @regus.email
  erb :home
end


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

