class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  attr_protected :roles, :api_token
  
  before_create :generate_api_key
  
  has_many :social_accounts, :dependent => :destroy
  has_many :updates, :dependent => :destroy
  
  def role_symbols
    self.roles.map { |r| r.name.to_sym }
  end
  
  def role?(role_name)
    role_symbols.include?(role_name)
  end
  
  def self.find_or_create_by_user_data(user_data)
    u = User.find_or_initialize_by_id(user_data["uid"])
    u.id = user_data["uid"]
    u.login = user_data["login"]
    u.email = user_data["email"]
    u.save
    u.givePrivelages!(user_data["roles"])
    
    u
  end
  
  def givePrivelages!(roles)
    self.roles.clear
    roles.each do |role|
      self.roles << Role.find_or_create_by_name(role)
    end
    self.save
  end
  
  def generate_api_key
    self.api_token = ActiveSupport::SecureRandom.hex(64)
  end
end
