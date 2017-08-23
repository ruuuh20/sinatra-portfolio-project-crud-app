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


end
