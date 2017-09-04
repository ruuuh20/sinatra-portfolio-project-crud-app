require 'pry'
class BooksController < ApplicationController

# index
get '/books' do
  redirect_if_not_logged_in
  @books = Book.all
  erb :'books/index'

end

get '/books/new' do
  redirect_if_not_logged_in
  erb :'books/new'
end

# new book posted
  post '/books' do
    unless Book.valid_params?(params)
      redirect to '/books/new'
    end
    # binding.pry
    if current_user
      # adding book to the specific course of the current user (courses.last?)
      @book = current_user.courses.last.books.create(:title => params[:title], :author => params[:author], :ISBN=> params[:ISBN])

      redirect to '/books'
    else
      redirect to '/'
    end
  end

  # show
  get '/books/:id' do
    redirect_if_not_logged_in
    @book = Book.find_by_id(params[:id])
    # binding.pry
    erb :'books/show'
  end


  get '/books/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @book = Book.find_by_id(params[:id])
    # binding.pry
      # validte??
    #  if @book.course_id == current_user.courses[].books.course_id
         erb :'/books/edit'
      #  else
      #    redirect to '/books'
      #  end
    # erb :'/books/edit'
  end

  patch '/books/:id' do
      @book = Book.find_by_id(params[:id])
      unless Book.valid_params?(params)
        redirect "/books/#{@book.id}/edit"
      end
      @book.update(params.select{|b| b=="title" || b=="author" || b=="ISBN"})
      redirect to "/books/#{@book.id}"
    
  end


end
