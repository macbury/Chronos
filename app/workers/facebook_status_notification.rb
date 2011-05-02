class FacebookStatusNotification < NotificationCheck
  
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)
    
    @post = graph.get_object(link.uid)
    @status = link.stream.streamable
    
    get_likes
    
    @status.save
  end
  
  def get_likes
    if @post["likes"] && @status.likes < @post["likes"]["count"]
      new_members = @post["likes"]["count"] - @status.likes
      @status.likes = @post["likes"]["count"]
      
      @reaction = link.stream.reactions.new
      @reaction.social_account = link.social_account
      @reaction.reaction_type = Reaction::Fan
      @reaction.message = "#{new_members} osób polubiło ten post"
      
      @reaction.save
      
      self.notify(@reaction.to_json)
    end
  end
  
end
