class FacebookEventNotification < NotificationCheck
  
  def perform
    @graph = Koala::Facebook::GraphAPI.new(link.social_account.token)

    @status = link.stream.streamable
    
    get_attending
    get_comments
    link.save
  end

  def get_attending
  
  end

  def get_comments
    @posts = []
    page = @graph.get_connections(link.uid, "feed", :limit => 100)
    @posts << page
    
    while true
      page = page.next_page
      break if page.nil? || page.size == 0
      @posts << page
    end
    
    @posts.flatten!
    
    if link.comments < @posts.size
      new_comments = @posts.size - link.comments
      link.comments = @posts.size
      
      @reaction = link.stream.reactions.new
      @reaction.social_account = link.social_account
      @reaction.reaction_type = Reaction::Comment
      @reaction.message = "Pojawiły się #{new_comments} nowe komentarze"
      
      @reaction.save
      
      self.notify(@reaction.to_json)
    end
  end

  
end
