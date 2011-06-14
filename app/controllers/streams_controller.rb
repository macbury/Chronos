class StreamsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    @streams = self.current_user.streams.includes(:streamable).order("created_at DESC").paginate :per_page => 50, :page => params[:page]
    
    respond_with(@streams, :include => [:streamable])
  end
  
  def show
    @stream = self.current_user.streams.includes(:streamable).find(params[:id])
    respond_with(@stream, :include => [:streamable])
  end
  
  def chart
    @stream = self.current_user.streams.find(params[:id])
    out = []

    visits = []
    last = 0
    7.downto(1).each do |day|
      visits << [ day.days.ago.at_beginning_of_day.to_i * 1000, last ]
      last += 1 + (rand * 30).round
    end

    out << { :label => "Wizyty", :data => visits }

    comments = []
    last = 0
    7.downto(1).each do |day|
      comments << [ day.days.ago.at_beginning_of_day.to_i * 1000, last ]
      last += 1 + (rand * 5).round
    end

    out << { :label => "Komentarze", :data => comments }

    likes = []
    last = 0
    7.downto(1).each do |day|
      likes << [ day.days.ago.at_beginning_of_day.to_i * 1000, last ]
      last += 1 + (rand * 10).round
    end

    out << { :label => "Lubie to", :data => likes }

    render :json => out
  end
end

