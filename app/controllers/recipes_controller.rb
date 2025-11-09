class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  def index
    @recipes = Recipe.visible_for(current_user).order(created_at: :desc)
  end

  def show
    if @recipe.draft? && @recipe.user != current_user
      redirect_to recipes_path, alert: "このレシピはまだ公開されていません。"
      return
    end
    @comment = Comment.new
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    set_status(@recipe)
    if @recipe.save
      notice_message = @recipe.published? ? "レシピを公開しました！" : "下書きとして保存しました。"
      redirect_to @recipe, notice: notice_message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    set_status(@recipe)
    if @recipe.update(recipe_params)
      notice_message = @recipe.published? ? "レシピを公開しました！" : "下書きとして保存しました。"
      redirect_to @recipe, notice: notice_message
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "レシピを削除しました"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :body, :status, :image, :tag_names)
  end

  def set_status(recipe)
    if params[:commit] == "公開する"
      recipe.status = :published
    else
      recipe.status = :draft
    end
  end
end
