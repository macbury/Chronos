class LinksController < ApplicationController
  before_filter :authenticate_user!

  def show
    @link = Link.joins(:owner => :user).where("users.id = ? AND links.id = ?", self.current_user.id, params[:id]).first
   
    if @link.published?
      redirect_to @link.social_url
    else
      redirect_to root_path
    end
  end

end