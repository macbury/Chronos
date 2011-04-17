class Event < ActiveRecord::Base
  has_one :stream, :as => :streamable

  def as_json(options = {})
    serializable_hash(:include => [:stream])
  end

  def to_facebook
    out = {
      :message => to_twitter
    }
    return out
  end
end

