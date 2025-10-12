class Admins::UsersController < ApplicationController
  layout "admin"
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.order(created_at: :asc)
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to admins_users_path, notice: "ユーザーを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
