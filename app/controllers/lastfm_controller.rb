class LastfmController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    redirect_to new_lastfm_path
  end
  
  def new
  
  end
  
  def create
    @account = self.current_user.social_accounts.find_or_initialize_by_name_and_social_type(params[:band], SocialAccount::LastFm)
    @account.password = params[:password]
    @account.login = params[:login]
    @account.name = params[:band]
    @account.save
    
    Delayed::Job.enqueue LastfmAsyncAuth.new(@account.id), TaskPriority::Auth, 5.seconds.from_now
  end
  
end
