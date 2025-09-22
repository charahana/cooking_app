class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to recipe_path(@recipe), notice: "コメントを投稿しました"
    else
      redirect_to recipe_path(@recipe), alert: "コメントを入力してください"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to recipe_path(@comment.recipe), notice: "コメントを削除しました"
    else
      redirect_to recipe_path(@comment.recipe), alert: "削除権限がありません"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
