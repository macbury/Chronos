class RedirectsController < ApplicationController
  
  def show
    id = params[:id].to_i(32)
    @link = ShortLink.find(id)
    @link.hits += 1
    @link.save
    
    redirect_to @link.url
  end
  
end
