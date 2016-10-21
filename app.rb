require 'sinatra' 
require 'sinatra/activerecord'
require 'paperclip'
require './models'
require 'sendgrid-ruby'

enable :sessions

set :database, "sqlite3:microblog.sqlite3"

$menu = [
  {page: 'Home', href: '/'},
  {page: 'Posts', href: '/generalPage'},
  {page: 'Personal', href: '/personal'},
  {page: 'Users', href: '/all_users'}
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
  redirect ('/personal')
  else 
    @error = 'Sorry you are not in our system'
    @error2 = "<img src='http://arcanumclub.ru/smiles/smile2.gif'>"
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
  redirect ('./')
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



post '/generalPage' do 
  
  posts_user = User.find_by(username: params[:username])
  
  if !posts_user.nil? 
    e = posts_user[:id].to_i
    @post = Post.create(content: params[:content], user_id: e) 
    
    erb :generalPage
  
  else 

    redirect ('/registration')
  
  end
end


#-------------------------
#UPDATE PERSONAL INFO PAGE 

get '/editpersonal' do
  @user = User.find(session[:user_id])
  @updated = @user[:fname] + " " + @user[:lname]
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
  redirect './'
end


get "/logout" do
  session.destroy
  redirect './'
  end
#------------------------------------------
#  ALL_USERS PAGE
get '/all_users' do
  @users = User.all
  erb :all_users
end
#------------------------------------------
# RECOVER PAGE 


get '/recover' do
  erb :recover
end


post '/recover' do 
  recover_user = User.find_by(email: params[:email]) 
  if /^[^@]+@[^\.]{2,}\.[^\.]{2,}$/ =~ params[:email] && recover_user.email == params[:email]
  mail = SendGrid::Mail.new(
    SendGrid::Email.new(email:"bayekeshov@gmail.com"),
    "Thanks for contacting us",
    SendGrid::Email.new(email: params[:email]),
    SendGrid::Content.new(type: 'text/plain', value: "Thanks for letting us know that you have problems with logging in.

      Here is your password " + + recover_user.password.to_s + " and username." + " " + recover_user.username 

    )
  )
  sg = SendGrid::API.new( api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  @msg = "Thank you! Please check your email"
  erb :recover
else
     @msg = "Not a valid email, please re-enter"
     @error.push( 'email' )

  erb :recover
end
end

helpers do
  def current_user 
    if session[:user_id]
      User.find(session[:user_id])
    end
    else
  end
end

