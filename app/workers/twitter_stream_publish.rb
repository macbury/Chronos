class TwitterStreamPublish < StreamPublish
  def perform
    twitter = Clients.twitter(link.social_account.token, link.social_account.secret)
    resp = twitter.post("/statuses/update.json", :status => link.stream.streamable.to_twitter)

    resp = JSON.parse(resp.body)
    if resp["id"]
      link.uid = resp["id"]
      link.save
    end
  end
end

