class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
     @book = Book.new
     @books = Book.all
     @user = User.find(current_user.id)
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="Book was successfully created."
      redirect_to book_path(Book.last.id.to_s)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end


  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
  end


  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice]="Book was successfully destroyed."
    redirect_to books_path
  end


  def update
     @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end


  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
