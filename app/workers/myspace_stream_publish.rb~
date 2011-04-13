class MyspaceStreamPublish < StreamPublish
  def perform
    myspace = Clients.myspace(link.social_account.token, link.social_account.secret)
    resp = myspace.post("/1.0/statusmood/@me/@self", link.owner.to_myspace)
    
    resp = JSON.parse(resp.body)
    if resp["id"]
      link.uid = resp["id"]
      link.save
    end
  end
end
