class UsersController < ApplicationController



  get '/' do
    erb :home
  end

# sign up
  get '/users/signup' do
    if session[:user_id]
      redirect to '/courses'

    else
      erb :'users/signup'
    end
  end

# after submitting signup form
  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to 'users/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password], :grade_level => params[:grade_level])
      # @user.save
      session[:user_id] = @user.id
      # raise params.inspect
      # raise @user.username
      redirect to '/courses'  # courses index
    end

  end


# login
  get '/users/login' do
    if session[:user_id]
      redirect to '/courses'

    else
      erb :'users/login'

    end

  end

  # submitting login form
  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/courses'
    else
      redirect to '/users/login'
    end
  end



  # User show page
  get '/users/:id' do
    erb :'users/show'
  end


end
