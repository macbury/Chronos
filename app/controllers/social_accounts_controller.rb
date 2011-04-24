class SocialAccountsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :accounts

  def index
    @social_accounts = self.current_user.social_accounts.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @social_accounts }
    end
  end

  def show
    render :layout => false
  end

end
