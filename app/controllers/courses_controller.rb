class CoursesController < ApplicationController

  get '/courses' do
    redirect_if_not_logged_in
    if current_user
      @courses = Course.all
      erb :'courses/index'
    end
  end

   get '/courses/new' do
     redirect_if_not_logged_in
     @error_message = params[:error]
     @semester_list = ['Fall', 'Winter', 'Spring', 'Summer']
     erb :'courses/new'
   end

  post '/courses' do
    if params[:name] == "" || params[:semester] == ""
      redirect to '/courses/new'
    else
      @course = current_user.courses.create(:name => params[:name], :semester => params[:semester])
      redirect to "/courses/#{@course.id}"
    end
  end

get '/courses/:id' do
  redirect_if_not_logged_in
  @course = Course.find_by_id(params[:id])
  erb :'courses/show'
end

get '/courses/:id/edit' do
  redirect_if_not_logged_in
  @error_message = params[:error]
  @semester_list = ['Fall', 'Winter', 'Spring', 'Summer']
  if logged_in?
    @course = Course.find_by_id(params[:id])
    if @course.user_id == current_user.id
      erb :'/courses/edit'
    else
      redirect to '/courses'
    end
  end

end

patch '/courses/:id' do
  if params[:name] == ""
    redirect to "/courses/#{params[:id]}/edit"
  else
    @course = Course.find_by_id(params[:id])
    @course.update(params.select{|b| b=="name" || b=="semester"})
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

    #  flash[:error] = "You do not have access"
    redirect to "/courses"
  end

end


end
