class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)
    @books = Book.page(params[:page]).reverse_order
    if @book.save
      redirect_to book_path(@book)
      flash[:success] = 'You have created book successfully.'
    else
      render :index
    end
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:success] = 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body ,:image)
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
   
  def correct_user
    @book =Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end