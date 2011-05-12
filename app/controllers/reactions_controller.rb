class ReactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :preload_resource
  respond_to :json

  def index
    if @stream
      @reactions = @stream.reactions.includes(:social_account).all
    else
      @reactions = self.current_user.reactions.newest.includes(:social_account).all
    end

    respond_with @reactions
  end
  
  def update
    if @stream
      @reaction = @stream.reactions.find(params[:id])
    else
      @reaction = Reaction.find(params[:id])
    end
    
    @reaction.update_attributes(params[:reaction])
    
    respond_with @reaction
  end
  
  protected

    def preload_resource
      @stream = self.current_user.streams.find(params[:stream_id]) if params[:stream_id]
    end
end
