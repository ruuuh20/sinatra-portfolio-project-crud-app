class CoursesController < ApplicationController


  # index - courses/index
  get '/courses' do
    if session[:user_id]
      @courses = Course.all
      erb :'courses/index'
    else
      redirect to '/'
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
  @course = Course.find_by(params[:id])
  erb :'courses/show'
end

# edit
get '/courses/:id/edit' do
  if logged_in?
    @course = Course.find_by(params[:id])
    if @course.user_id == current_user.id #validating
      erb :'/courses/edit'
    else
      redirect to '/courses'
    end
  else
    redirect_if_not_logged_in
  end

end

patch '/courses/:id' do
  if params[:name] == ""
    redirect to "/courses/#{params[:id]}/edit"
  else
    @course = Course.find_by(params[:id])
    @course.update(params)
    redirect to "/courses/#{@course.id}"
  end

end

delete '/courses/:id/delete' do
  # if logged_in?
  #   @course = Course.find_by(params[:id])
  #   if @course.user_id == current_user.id
  #     @course.delete
  #     redirect to '/courses'
  #   else
  #     redirect to '/courses'
  #   end
  # else
  #   redirect_if_not_logged_in
  # end
  course = current_user.courses.find_by(:id => params[:id])
  if course && course.destroy
    redirect to '/courses'
  else
    redirect to "/courses/#{course.id}"
  end

end


end
