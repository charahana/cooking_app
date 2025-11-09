class Admins::CommentsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!
  before_action :set_comment, only: [:destroy]

  def index
    @comments = Comment.includes(:user, :recipe).order(created_at: :desc)
  end

  def destroy
    @comment.destroy
    redirect_to admins_comments_path, notice: "コメントを削除しました"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
