class SocialAccount < ActiveRecord::Base
  belongs_to :user
  Facebook = 0
  Twitter = 1
  Blip = 2
  Flaker = 3
  MySpace = 4
  
  Types = { SocialAccount::Facebook => :facebook, SocialAccount::Twitter => :twitter, SocialAccount::Blip => :blip, SocialAccount::Flaker => :flaker, SocialAccount::MySpace => :myspace }
  
  def facebook?
    self.social_type == SocialAccount::Facebook
  end
  
  def self.findType(f_name)
    sid = 0
    SocialAccount::Types.each do |id, name|
      if name == f_name.to_sym
        sid = id
        break
      end
    end
    
    return sid
  end
  
end
