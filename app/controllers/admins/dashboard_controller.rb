class Admins::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @users_count = User.count
    @recipes_count = Recipe.count
    @today_users_count = User.where(created_at: Time.zone.today.all_day).count
    @today_recipes_count = Recipe.where(created_at: Time.zone.today.all_day).count
    @recent_recipes = Recipe.order(created_at: :desc).limit(5)
  end
end
