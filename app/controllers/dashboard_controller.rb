class DashboardController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  #ssl_required :all

  def index

  end
end

