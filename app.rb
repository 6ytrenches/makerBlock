require 'sinatra' 
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:uncubed.sqlite3"


get '/' do 
  @users = User.all
  
end

get '/posts' do
  @posts = Post.all
  erb :mainPage
end

$menu = [
  {page: 'main', href: '/generalPage'},
  {page: 'home', href: '/home'}
  ]
end