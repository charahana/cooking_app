class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :show, :edit, :update, :withdraw]
  before_action :set_user, only: [:show, :edit, :update]

  def mypage
    @user = current_user
    @recipes = @user.recipes.order(created_at: :desc)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(created_at: :desc)
  end

  def edit
    redirect_to root_path unless @user == current_user
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_users_path, notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def withdraw
    current_user.update(status: 'inactive')
    reset_session
    redirect_to new_user_registration_path, notice: "退会処理が完了しました"
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
