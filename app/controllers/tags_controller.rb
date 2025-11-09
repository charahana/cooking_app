class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @recipes = @tag.recipes
  end

  def index
    @tags = Tag.all.order(:name)
  end
end
