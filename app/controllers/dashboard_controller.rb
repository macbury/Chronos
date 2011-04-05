class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @updates = self.current_user.updates.includes(:links).all
  end
end
