class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    
  end
  
  def create
    self.current_user.user_type = params[:user][:type]
    self.current_user.save
    
    redirect_to root_path
  end
  
end
