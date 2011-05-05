class UpdatesController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json
  
  def chart
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


  def create
    @update = Update.new(params[:update])
    @stream = self.current_user.streams.create(:streamable => @update) if @update.save

    respond_with(@update, :include => [:stream])
  end

end
