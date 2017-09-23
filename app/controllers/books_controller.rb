require 'pry'
class BooksController < ApplicationController

get '/courses/:course_id/books' do
  redirect_if_not_logged_in
  @course = current_user.courses.find_by(id: params[:course_id])
  @books = @course.books
  erb :'books/index'

end

get '/courses/:course_id/books/new' do
  redirect_if_not_logged_in
  @course = current_user.courses.find_by_id(params[:course_id])
  erb :'books/new'
end

post '/courses/:course_id/books' do
  redirect_if_not_logged_in
    unless Book.valid_params?(params)
      redirect to '/books/new'
    end
  @course = current_user.courses.find_by(id: params[:course_id])
  @book = @course.books.build(:title => params[:title], :author => params[:author], :ISBN=> params[:ISBN], :course_id => params[:course_id])
    if @book.save
      redirect to "courses/#{@course.id}/books"
    else
      redirect to "/courses/#{@course.id}/books/new"
    end
end

  get '/courses/:course_id/books/:id' do
    redirect_if_not_logged_in
    @book = Book.find_by_id(params[:id])
    erb :'books/show'
  end


  get '/courses/:course_id/books/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @book = Book.find_by_id(params[:id])
    book_course_id = @book.course_id
    course = Course.find_by_id(book_course_id)
          if @book.course_id == course.id
             erb :'/books/edit'
          else
             redirect to '/books'
          end
  end

  patch '/courses/:course_id/books/:id' do
      @book = Book.find_by_id(params[:id])
      unless Book.valid_params?(params)
        redirect "/books/#{@book.id}/edit"
      end
      @book.update(params.select{|b| b=="title" || b=="author" || b=="ISBN"})
      redirect to "/books/#{@book.id}"
  end
end
