class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @users = User.all
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
  end


  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="User was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
