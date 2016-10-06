helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end

get '/' do

  @posts = Post.order(created_at: :desc)
  erb(:index)

end


get '/signup' do      #user navigates to the path /signup
  @user = User.new    #setup empty @user object
  erb(:signup)        #render "app/views/signup.erb"
end

post '/signup' do
  # params.to_s   #params hash allows access to our user-submitted values
  
  # grab user input values from params
  email       = params[:email]
  avatar_url  = params[:avatar_url]
  username    = params[:username]
  password    = params[:password]
  
    # instantiate a User
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
    
    # if user validations pass and user is saved
  if @user.save
    redirect to('/login')
  else
    erb(:signup)  # when error, brings us back to the signup page
  # display simple error message
  end
end


get '/login' do   # when a GET request comes into /login
  erb(:login)     # render app/view/login.erb
end

post '/login' do
  username = params[:username]
  password = params[:password]
  
  # find user by name
  user = User.find_by(username: username)
  
  if user && user.password == password
    session[:user_id] = user.id
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

get '/' do
  @posts = Post.order(created_at: :desc)
  erb(:index)
end
