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
    "User #{username} saved!"    
    # return readable represenation of User object
  
  else
    erb(:signup)  # when error, brings us back to the signup page
  # display simple error message
  end
end