class Link < ActiveRecord::Base
  belongs_to :update
  belongs_to :social_account
  
  def publised?
    self.uid.present?
  end
end
