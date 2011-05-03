class FacebookStatusNotification < NotificationCheck
  
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)
    
    @post = graph.get_object(link.uid)
    @status = link.stream.streamable
    
    get_likes
    get_comments
    
    link.save
  end

  def get_comments
    if @post["comments"] && link.comments < @post["comments"]["count"]
      new_comments = @post["comments"]["count"] - link.comments
      link.comments = @post["comments"]["count"]
      
      @reaction = link.stream.reactions.new
      @reaction.social_account = link.social_account
      @reaction.reaction_type = Reaction::Comment
      @reaction.message = "Pojawiły się #{new_comments} nowe komentarze"
      
      @reaction.save
      
      self.notify(@reaction.to_json)
    end
  end

  def get_likes
    if @post["likes"] && link.likes < @post["likes"]["count"]
      new_members = @post["likes"]["count"] - link.likes
      link.likes = @post["likes"]["count"]
      
      @reaction = link.stream.reactions.new
      @reaction.social_account = link.social_account
      @reaction.reaction_type = Reaction::Fan
      @reaction.message = "#{new_members} osób polubiło ten post"
      
      @reaction.save
      
      self.notify(@reaction.to_json)
    end
  end
  
end
