class DashboardController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  #ssl_required :all

  def index
    @accounts = self.current_user.social_accounts.all
  end
end

