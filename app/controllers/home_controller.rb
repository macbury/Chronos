class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    render :text => 'Hello'
  end
  
  def api
    respond_to do |format|
      format.xml { render :xml => { :test => "Is Working" } }
      format.html { render :text => 'Working' }
    end
  end
  
end
