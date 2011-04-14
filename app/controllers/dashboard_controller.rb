class DashboardController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard

  def index
    
    respond_to do |format|
      format.html
      format.json { render :json => self.current_user.streams.includes(:streamable).all.to_json(:include => :streamable) }
    end
    
  end
end
