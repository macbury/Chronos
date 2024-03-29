class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :preload_resource, :only => :index
  respond_to :json, :only => :index

  def index
    @links = @stream.links.includes(:social_account).all
    respond_with @links
  end

  def show
    @link = Link.find(params[:id])

    if @link.published?
      redirect_to @link.social_url
    else
      redirect_to root_path
    end
  end

  protected

    def preload_resource
      @stream = self.current_user.streams.find(params[:stream_id])
    end

end

