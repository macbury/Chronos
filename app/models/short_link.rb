class ShortLink < ActiveRecord::Base
  belongs_to :user
  has_many :hits, :dependent => :destroy

  #TO DO Add validation on url and skip urls in our domain for tz.rhmusic.pl!
end

