class Status < ActiveRecord::Base
  has_one :stream, :as => :streamable

  validates :body, :presence => true, :length => 5..140

  def as_json(options = {})
    serializable_hash(:include => [:stream])
  end
end

