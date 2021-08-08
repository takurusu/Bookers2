class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:success] = 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless @user == current_user
  end
end