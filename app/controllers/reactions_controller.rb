class ReactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :preload_resource
  respond_to :json

  def index
    @reactions = @stream.reactions.includes(:social_account).all
    respond_with @reactions
  end
  
  protected

    def preload_resource
      @stream = self.current_user.streams.find(params[:stream_id])
    end
end
