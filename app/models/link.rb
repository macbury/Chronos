class Link < ActiveRecord::Base
  Pending = 0
  Working = 1
  Success = 2
  Error = 3
  Failure = 4

  belongs_to :stream
  #belongs_to :update
  belongs_to :social_account

  after_create :enqueue

  def published?
    self.status_type == Link::Success
  end

  def as_json(options = {})
    serializable_hash(:methods => [:social_account], :only => [:id, :status_type, :stream_id, :progress])
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
    if stream.streamable_type == "Status"
      enqueue_status
    elsif stream.streamable_type == "Event"
      enqueue_event
    elsif stream.streamable_type == "Album"
      enqueue_album
    end
  end
  
  def enqueue_album
    if self.social_account.social_type == SocialAccount::Facebook
      Delayed::Job.enqueue FacebookAlbumPublish.new(self.id), TaskPriority::AlbumPublish, 5.seconds.from_now
    end
  end
  
  def enqueue_event
    if self.social_account.social_type == SocialAccount::Facebook
      Delayed::Job.enqueue FacebookEventPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    elsif self.social_account.social_type == SocialAccount::Muzzo
      Delayed::Job.enqueue MuzzoEventPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    end
  end

  def enqueue_status
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
    elsif self.social_account.social_type == SocialAccount::MySpace
      Delayed::Job.enqueue MyspaceStreamPublish.new(self.id), TaskPriority::StatusPublish, 5.seconds.from_now
    end
  end

  #handle_asynchronously :enqueue
end

