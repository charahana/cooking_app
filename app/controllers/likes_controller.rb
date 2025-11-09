class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:create]

  def create
    like = @recipe.likes.find_by(user: current_user)
    if like
      like.destroy
    else
      @recipe.likes.create(user:current_user)
    end
    redirect_back(fallback_location: recipes_path)
  end

  def index
    @liked_recipes = current_user.likes.includes(:recipe).map(&:recipe)
  end 

    private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
