class DashboardController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard

  def index
    
  end
end
