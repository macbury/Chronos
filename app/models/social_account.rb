require 'crypt/blowfish'
class SocialAccount < ActiveRecord::Base
  belongs_to :user
  has_many :links, :dependent => :destroy

  Facebook = 0
  Twitter = 1
  Blip = 2
  Flaker = 3
  MySpace = 4
  LastFm = 5
  Muzzo = 6
  YouTube = 7
  Types = { SocialAccount::Facebook => :facebook, SocialAccount::Twitter => :twitter, SocialAccount::Blip => :blip, SocialAccount::Flaker => :flaker, SocialAccount::MySpace => :myspace, SocialAccount::LastFm => :lastfm, SocialAccount::Muzzo => :muzzo, SocialAccount::YouTube => :you_tube }

  scope :for_types, lambda { |*args| where("social_accounts.social_type IN (?)", args.first) }

  def as_json(options = {})
    serializable_hash(:only => [:id, :social_type, :name], :methods => [:type_name])
  end

  def facebook?
    self.social_type == SocialAccount::Facebook
  end

  def type_name
    SocialAccount::Types[self.social_type]
  end

  def password=(new_password)
    blowfish = Crypt::Blowfish.new(PASSWORD_TOKEN_HASH)
    3.times { new_password = blowfish.encrypt_string(new_password) }
    write_attribute :password, new_password
  end

  def password
    p = read_attribute(:password)
    blowfish = Crypt::Blowfish.new(PASSWORD_TOKEN_HASH)
    if p
      3.times { p = blowfish.decrypt_string(p) }
    end
    p
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

