class FacebookStreamPublish < StreamPublish
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)
      
    resp = graph.put_object(link.social_account.uid, "feed", link.update.to_facebook)
    if resp["id"]
      link.uid = resp["id"].split("_").last
      link.save
    end
  end
end
