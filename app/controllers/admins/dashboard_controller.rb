class Admins::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
  end
end
