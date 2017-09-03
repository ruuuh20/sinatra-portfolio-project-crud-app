class BooksController < ApplicationController

# index
get '/books' do
  @books = Book.all
  erb :'books/index'

end

get '/books/new' do
  redirect_if_not_logged_in
  erb :'books/new'
end

# new book posted
  post '/books' do
    if current_user
      @book = Book.create(:title => params[:title], :author => params[:author], :ISBN=> params[:ISBN])
      redirect to '/books'
    else
      redirect to '/'
    end
  end


  get '/books/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @book = Book.find_by_id(params[:id])
      # validte?? if @book.course_id == current_user.id #validating
    erb :'/books/edit'
      end
    end
  end

end
