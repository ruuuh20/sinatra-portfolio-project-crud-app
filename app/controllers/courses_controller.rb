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

  # Register a new course
   get '/courses/new' do
     @semester_list = ['Fall', 'Winter', 'Spring', 'Summer']  #for checkboxes
     erb :'courses/new'
   end

# submitted from New Course form
  post '/courses' do
    if params[:name] == "" || params[:semester] == ""
      redirect to '/courses/new'
    else
      @course = current_user.courses.create(:name => params[:name], :semester => params[:semester])
      redirect to "/courses/#{@course.id}"    #show
    end
  end

# show
get '/courses/:id' do
  redirect_if_not_logged_in
  @course = Course.find(params[:id])
  erb :'courses/show'
end

# edit
get '/courses/:id/edit' do
  
end


end
