class RedirectsController < ApplicationController
  
  def show
    id = params[:id].to_i(32)
    @link = ShortLink.find(id)
    @link.hits.find_or_create_by_ip_and_referrer(request.remote_ip, request.referrer)
    
    redirect_to @link.url
  end
  
end
