class OauthController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    omniauth = request.env["omniauth.auth"]
    provider_id = SocialAccount.findType(omniauth['provider'])
    @account = self.current_user.social_accounts.find_or_initialize_by_uid_and_social_type(omniauth['uid'], provider_id)
    @account.token = omniauth['credentials']['token']
    @account.secret = omniauth['credentials']['secret']
    
    if @account.facebook?
      redirect_to new_facebook_page_path(:token => omniauth['credentials']['token'])
    else
      Rails.logger.info omniauth.to_yaml
      @account.name = omniauth["user_info"].nil? ? omniauth.user_info['nickname'] : omniauth["user_info"]["nickname"]
      @account.save
      
      redirect_to social_accounts_path
    end
  end
  
  def facebook
    
  end
end
