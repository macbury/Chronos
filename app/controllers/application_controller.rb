class ApplicationController < ActionController::Base
  #protect_from_forgery
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
      if request.format == Mime::XML || request.format == Mime::JSON
        #skip_before_filter :verify_authenticity_token
        @current_user = User.find_by_api_token(params[:api_key])
        render :xml => { :error => "Invalid Api Key!" } if @current_user.nil?
      else
        redirect_to login_path unless logged_in?
      end
    end
    
    def logged_in?
      !self.current_user.nil?
    end
    
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
      @current_user
    end

end
