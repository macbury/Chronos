class MyspaceStreamPublish < StreamPublish
  def perform
    myspace = Clients.myspace(link.social_account.token, link.social_account.secret)
    resp = blip.post("/updates.json", :body => link.owner.to_twitter)
    
    resp = JSON.parse(resp.body)
    if resp["id"]
      link.uid = resp["id"]
      link.save
    end
  end
end
