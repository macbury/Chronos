class Reaction < ActiveRecord::Base
  belongs_to :social_account
  belongs_to :stream
  
  Fan = 0
  
end
