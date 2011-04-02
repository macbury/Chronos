class Link < ActiveRecord::Base
  belongs_to :update
  belongs_to :social_account
  
  after_create :send_to

  def published?
    self.uid.present?
  end
  
  def send_to
    if self.social_account.social_type == SocialAccount::Facebook
      graph = Koala::Facebook::GraphAPI.new(self.social_account.token)
      
      resp = graph.put_object(self.social_account.uid, "feed", self.update.to_facebook)
      if resp["id"]
        uid = resp["id"].split("_").last
        
        self.save
      end
    elsif self.social_account.social_type == SocialAccount::Twitter
      twitter = Clients.twitter(self.social_account.token, self.social_account.secret)
      resp = twitter.post("/statuses/update.json", :status => self.update.to_twitter)
      
      resp = JSON.parse(resp.body)
      if resp["id"]
        uid = resp["id"]
        self.save
      end
    elsif self.social_account.social_type == SocialAccount::Blip
      blip = Clients.blip(self.social_account.token, self.social_account.secret)
      resp = blip.post("/updates.json", :body => self.update.to_twitter)
      
      resp = JSON.parse(resp.body)
      if resp["id"]
        uid = resp["id"]
        self.save
      end
    elsif self.social_account.social_type == SocialAccount::Flaker
      flaker = Clients.flaker(self.social_account.token, self.social_account.secret)
      resp = flaker.post("/api/type:submit", :text => self.update.to_flaker, :link => self.update.short_url)
      
      resp = JSON.parse(resp.body)
      if resp["info"]
        uid = resp["info"].gsub(/[^0-9]/i, "")
        self.save
      end
    end
  end
  handle_asynchronously :send_to
  
end
