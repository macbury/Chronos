class Update < ActiveRecord::Base
  belongs_to :user
  has_many :links, :dependent => :destroy
  
  after_create :build_links
  
  def build_links
    self.user.social_accounts.all.each do |sa|
      self.links.create(:social_account_id => sa.id)
    end
  end
  
end
