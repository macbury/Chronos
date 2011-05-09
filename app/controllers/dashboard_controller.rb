class DashboardController < ApplicationController
  before_filter :redirect_if_production, :authenticate_user!
  set_tab :dashboard
  #ssl_required :all

  def index
    @accounts = self.current_user.social_accounts.all
  end
  
  protected
    def redirect_if_production
      redirect_to("http://rhmusic.pl") if Rails.env == "production" && !logged_in?
    end
end

