class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json

  def create
    @album = Album.new(params[:album])
    @stream = self.current_user.streams.create(:streamable => @album) if @status.save

    respond_with(@album, :include => [:stream])
  end
end
