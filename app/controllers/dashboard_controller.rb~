class DashboardController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard

  def index
    @updates = self.current_user.updates.includes(:links).order("publish_at DESC").all
  end
end
