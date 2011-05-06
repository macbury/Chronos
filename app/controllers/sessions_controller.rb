class SessionsController < ApplicationController
  def new

    redirect_to client.web_server.authorize_url( :redirect_uri => oauth_process_url, :scope => '', :response_type => "code")
  end
  
  def create
    @access_token = client.web_server.get_access_token(params[:code], :redirect_uri => oauth_process_url)
    user_data = JSON.parse(@access_token.get('/me'))
  
    u = User.find_or_create_by_user_data(user_data)
    
    session[:access_token] = @access_token.token
    session[:user_id] = u.id
    
    if u.type?
      redirect_to root_path
    else
      redirect_to edit_account_path
    end
  end
  
  def destroy
    session.clear
    redirect_to root_path, :notice => "Zostales wylogowany"
  end
end
