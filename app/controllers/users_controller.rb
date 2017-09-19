class UsersController < ApplicationController

  get '/' do
    if logged_in?
      redirect to '/courses'
    else
      erb :home
    end
  end

  get '/users/signup' do
    if current_user
      redirect to '/courses'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :password => params[:password], :grade_level => params[:grade_level])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/courses'
    else
      redirect to '/users/signup'
    end
  end

  get '/users/login' do
    @error_message = params[:error]
    if logged_in?
      redirect to '/courses'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/courses'
    else
      redirect to '/users/login'
    end
  end

  get '/users/:id' do
    erb :'users/show'
  end

  get '/logout' do
    if session[:user_id]
      logout!
      redirect to '/'
    else
      redirect to '/'
    end
  end

end

#Request Flow
#-> View
#-> POST Request sent from View
#-> Server
#-> Uses the Rack Middleware
#-> Rack looks at the sinatra code and tryies to find the matching POST Request Route

#Reponse Flow
#-> Find the required data that was requested
#-> Return the data / view

# TODO:
# - If logged in - Navbar show Courses link to /courses  [x]
# - If logged in home route should redirect to /courses  [x]
# - Make a course viewable with a link from the /courses [x]
