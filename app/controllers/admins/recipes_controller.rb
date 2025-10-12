class Admins::RecipesController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @recipes = Recipe.order(created_at: :asc)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to admins_recipes_path, notice: "レシピを削除しました。"
  end
end
