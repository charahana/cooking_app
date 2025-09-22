class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @keyword = params[:keyword]
    if @range == "User"
      @results = User.where("name LIKE ?", "%#{@keyword}%")
    else
      @results = Recipe.where("title LIKE ? OR body LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
    end
  end
end
