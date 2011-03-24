class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?, :current_user, :access_token
  
  protected
  
    def client
      RhCore::Client
    end
    
    def permission_denied
      redirect_to root_path, :notice => "Nie masz wystarczajacych uprawnien aby moc odwiedzic ta strone"
    end
    
    def access_token
      @access_token ||= OAuth2::AccessToken.new(client, session[:access_token]) if session[:access_token]
    end
    
    def authenticate_user!
      redirect_to login_path, :notice => "Musisz byc zalogowany!" unless logged_in?
    end
    
    def logged_in?
      !self.current_user.nil?
    end
    
    def current_user
      @current_user ||= User.find_by_uid(session[:user_id]) if session[:user_id]
      @current_user
    end
end
