class RedirectsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]

  def show
    id = params[:id].to_i(32)
    @link = ShortLink.find(id)
    @link.hits.find_or_create_by_ip_and_referrer(request.remote_ip, request.referrer)

    redirect_to @link.url
  end

  def create
    @short_link = self.current_user.short_links.find_or_initialize_by_url(params[:url])

    if @short_link.save
      render :json => { :link => short_link_url(:id => @short_link.id.to_s(32)) }
    else
      render :json => { :error => "Błąd nie można skrócić linku!" }
    end
  end

end

