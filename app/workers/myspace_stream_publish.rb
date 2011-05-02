class MyspaceStreamPublish < StreamPublish
  def perform
    myspace = Clients.myspace(link.social_account.token, link.social_account.secret)
    resp = myspace.set_status(link.social_account.uid, link.stream.streamable.to_myspace)

    #resp = JSON.parse(resp.body)
    #if resp["id"]
    #  link.uid = resp["id"]
    #  link.save
    #end
  end
end

