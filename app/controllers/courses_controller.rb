class CoursesController < ApplicationController


  # index - courses/index
  get '/courses' do
    if session[:user_id]
      @courses = Course.all
      erb :'courses/index'
    else
      redirect to 'users/login'
    end
  end

# submitted from New Course form
  post '/courses' do
    @course = Course.create(:name => params[:name], :semester => params[:semester])
    redirect to '/courses'
  end

  get '/courses/new' do
    erb :'courses/new'
  end


end
