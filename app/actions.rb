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

# ADDING POSTS
# first, display the form (GET):

get '/posts/new' do
  @post = Post.new
  erb(:"posts/new")
end

# second, process the submission (POST):

post '/posts' do
  photo_url = params[:photo_url]
  
  #instantiate new Post
  @post = Post.new({ photo_url: photo_url, user_id: current_user.id })
  
  #if @post validates, save
  if @post.save
    redirect(to('/'))
  else
    erb(:"posts/new")
  end
end

# DISPLAY INDIVIDUAL POST

get '/posts/:id' do   #:id is the wildcard, specifically and id value
  @post = Post.find(params[:id])  # find the post with the ID from the URL
  erb(:"posts/show")  # render the show.erb file
end

# CREATE ACTION FOR COMMENT FORM
post '/comments' do
  # point values form params to variables
  text = params[:text]
  post_id = params[:post_id]
  
  comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id })

  comment.save
  
  redirect(back)
end

