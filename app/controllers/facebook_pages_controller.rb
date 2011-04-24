class FacebookPagesController < ApplicationController
  before_filter :authenticate_user!, :load_pages
  
  def new
    
  end
  
  def create
    
    if @pages.map{ |p| p["id"].to_i }.include?(params[:page][:id].to_i)
      @pages.each do |page|
        if page["id"].to_i == params[:page][:id].to_i
          @account = self.current_user.social_accounts.find_or_initialize_by_uid_and_social_type(params[:page][:id], SocialAccount::Facebook) 
          @account.token = page["access_token"]
          @account.name = page["name"]
          
          @account.save
          break
        end
      end
      
      
      redirect_to root_path(:anchor => "!/accounts")
    else
      render :action => 'new'
    end
  end
  
  protected
    def load_pages
      redirect_to social_accounts_path if params[:token].nil?
      @graph = Koala::Facebook::GraphAPI.new(params[:token])
      
      @pages = @graph.get_connections("me", "accounts")
    end
end
