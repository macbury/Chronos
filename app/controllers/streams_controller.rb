class StreamsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    @streams = self.current_user.streams.includes(:streamable).order("created_at DESC").all.to_json(:include => :streamable)
    respond_with(@streams)
  end

end
