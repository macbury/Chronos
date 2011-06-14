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
    if stream.streamable_type == "Status" || stream.streamable_type == "Update"
      run_job("StreamPublish", TaskPriority::StatusPublish, 5.seconds.from_now)
    elsif stream.streamable_type == "Event"
      run_job("EventPublish", TaskPriority::StatusPublish, 5.seconds.from_now)
    elsif stream.streamable_type == "Album"
      run_job("AlbumPublish", TaskPriority::AlbumPublish, 10.seconds.from_now)
    end
  end
  
  def run_job(name, priority, time)
    klass_name = self.social_account.class_name + name
    begin
      klass = (klass_name).constantize
      Delayed::Job.enqueue klass.new(self.id), priority, time
      Rails.logger.info "Adding #{klass_name} to job Quee!"
    rescue Exception => e
      Rails.logger.error "Define #{klass_name}!"
    end
  end
  
  def check_notification
    if stream.streamable_type == "Status" || stream.streamable_type == "Update"
      run_job("StatusNotification", TaskPriority::Notification, 1.seconds.from_now)
    elsif stream.streamable_type == "Event"
      run_job("EventNotification", TaskPriority::Notification, 1.seconds.from_now)
    elsif stream.streamable_type == "Album"
      run_job("AlbumNotification", TaskPriority::Notification, 1.seconds.from_now)
    end
  end
  
  #handle_asynchronously :enqueue
end

