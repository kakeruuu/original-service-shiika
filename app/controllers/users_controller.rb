class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit]
  before_action :correct_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "登録に成功しました"
      redirect_to @user
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
   
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "更新できませんでした"
      render :new
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
  end
  
  def correct_user
    @user = current_user
    unless @user
      redirect_to '/'
    end
  end
end
