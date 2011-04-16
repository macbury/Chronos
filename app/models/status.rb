class Status < ActiveRecord::Base
  has_one :stream, :as => :streamable
end
