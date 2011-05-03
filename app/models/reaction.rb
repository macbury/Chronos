class Reaction < ActiveRecord::Base
  belongs_to :social_account
  belongs_to :stream
  
  Fan = 0
  Comment = 1
  
  def as_json(options = {})
    serializable_hash(:methods => [:social_account], :only => [:id, :message, :stream_id, :created_at])
  end
end
