class Admins::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @users_count = User.count
    @recipes_count = Recipe.count
  end
end
