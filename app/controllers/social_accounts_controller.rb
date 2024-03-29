class SocialAccountsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :accounts
  respond_to :json
  
  def index
    @social_accounts = self.current_user.social_accounts.all

    respond_with(@social_accounts)
  end


end
