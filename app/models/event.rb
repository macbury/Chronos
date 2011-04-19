class Event < ActiveRecord::Base
  PublishTo = [SocialAccount::Facebook, SocialAccount::MySpace, SocialAccount::LastFm, SocialAccount::Muzzo]

  has_one :stream, :as => :streamable

  def as_json(options = {})
    serializable_hash(:include => [:stream])
  end

  def send_to
    Event::PublishTo
  end

  def to_facebook
    out = {
      :name => self.title,
      :description => description,
      :start_time => Event.prepareFBTime(start_date).to_time.xmlschema,
      :end_time => Event.prepareFBTime(end_date).to_time.xmlschema,
      :location => self.where,
    }

    return out
  end

  def self.prepareFBTime(time)
    time + 7.hours
  end
end

