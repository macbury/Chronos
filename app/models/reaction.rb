class Reaction < ActiveRecord::Base
  belongs_to :social_account
  belongs_to :stream
  
  scope :newest, order("reactions.created_at DESC").where("reactions.unread = ?", true)
  
  attr_accessible :unread
  
  Fan = 0
  Comment = 1
  
  def as_json(options = {})
    serializable_hash(:methods => [:social_account], :only => [:id, :message, :stream_id, :created_at, :unread])
  end
end
