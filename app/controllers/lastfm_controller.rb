class LastfmController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    redirect_to new_lastfm_path
  end
  
  def new
  
  end
  
  def create
    @lastfm = LastFm.new(params[:login], params[:password])
    
    if @lastfm.logged_in?
      account = self.current_user.social_accounts.find_or_initialize_by_uid_and_social_type(params[:band], SocialAccount::LastFm)
      account.password = @lastfm.password
      account.uid = params[:band]
      account.login = @lastfm.login
      account.name = params[:band]
      account.save
      redirect_to social_accounts_path
    else
      flash[:notice] = "Nieprawidłowe hasło lub login"
      render :action => "new"
    end
  end
  
end