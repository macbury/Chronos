require "faye"

faye_server = Faye::RackAdapter.new(:mount => '/realtime', :timeout => 45)
run faye_server
