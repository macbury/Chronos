class Link < ActiveRecord::Base
  Pending = 0
  Working = 1
  Success = 2
  Error = 3
  Failure = 4
  
  belongs_to :update
  belongs_to :social_account
  
  after_create :enqueue

  def published?
    self.status_id == Link::Success
  end

  def enqueue
    if self.social_account.social_type == SocialAccount::Facebook
      Delayed::Job.enqueue FacebookStreamPublish.new(self.id)
    elsif self.social_account.social_type == SocialAccount::Twitter
      Delayed::Job.enqueue TwitterStreamPublish.new(self.id)
    elsif self.social_account.social_type == SocialAccount::Blip
      Delayed::Job.enqueue BlipStreamPublish.new(self.id)
    elsif self.social_account.social_type == SocialAccount::Flaker
      Delayed::Job.enqueue FlakerStreamPublish.new(self.id)
    end
  end
  
end
