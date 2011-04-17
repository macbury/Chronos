class MyspaceStreamPublish < StreamPublish
  def perform
    myspace = Clients.myspace(link.social_account.token, link.social_account.secret)
    resp = myspace.post("/v1/users/#{link.social_account.uid}/status", link.stream.streamable.to_myspace)

    resp = JSON.parse(resp.body)
    if resp["id"]
      link.uid = resp["id"]
      link.save
    end
  end
end

