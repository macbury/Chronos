class Status < ActiveRecord::Base
  has_one :stream, :as => :streamable

  validates :body, :presence => true, :length => 5..140

  def as_json(options = {})
    serializable_hash(:include => [:stream])
  end

  def to_twitter
    ModelHelper.strip_tags(self.body).strip
  end

  def to_flaker
    to_twitter
  end

  def to_lastfm
    to_twitter
  end

  def to_facebook
    out = {
      :message => to_twitter
    }
    return out
  end
end

