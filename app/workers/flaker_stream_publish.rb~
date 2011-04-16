class FlakerStreamPublish < StreamPublish
  def perform
    flaker = Clients.flaker(link.social_account.token, link.social_account.secret)
    resp = flaker.post("/api/type:submit", :text => link.update.to_flaker, :link => link.update.short_url)
    
    resp = JSON.parse(resp.body)
    if resp["info"]
      link.uid = resp["info"].gsub(/[^0-9]/i, "")
      link.save
    end
  end
end
