class Link < ActiveRecord::Base
  Pending = 0
  Working = 1
  Success = 2
  Error = 3
  Failure = 4
  
  belongs_to :owner, :foreign_key => "update_id", :class_name => "Update"
  #belongs_to :update
  belongs_to :social_account
  
  after_create :enqueue

  def published?
    self.status_type == Link::Success
  end
  
  def as_json(options = {})
    serializable_hash(:methods => [:social_account], :only => [:id, :status_type])
  end
  
  def social_url
    return unless published?
    if self.social_account.social_type == SocialAccount::Facebook
      return "http://www.facebook.com/#{self.social_account.uid}/posts/#{self.uid.split("_").last}"
    elsif self.social_account.social_type == SocialAccount::Twitter
      return "http://twitter.com/#{self.social_account.name}/status/#{self.uid}"
    elsif self.social_account.social_type == SocialAccount::Blip
      return "http://blip.pl/s/#{self.uid}"
    elsif self.social_account.social_type == SocialAccount::Flaker
      return "http://flaker.pl/f/#{self.uid}"
    elsif self.social_account.social_type == SocialAccount::LastFm
      return "http://www.lastfm.pl/music/#{CGI.escape(self.social_account.name)}#shoutboxContainer"
    end
  end
  
  def enqueue
    if self.social_account.social_type == SocialAccount::Facebook
      Delayed::Job.enqueue FacebookStreamPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    elsif self.social_account.social_type == SocialAccount::Twitter
      Delayed::Job.enqueue TwitterStreamPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    elsif self.social_account.social_type == SocialAccount::Blip
      Delayed::Job.enqueue BlipStreamPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    elsif self.social_account.social_type == SocialAccount::Flaker
      Delayed::Job.enqueue FlakerStreamPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    elsif self.social_account.social_type == SocialAccount::LastFm
      Delayed::Job.enqueue LastfmStreamPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    end
  end
  
end
