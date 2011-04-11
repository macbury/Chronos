require 'omniauth'
require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Myspace < OAuth
      # Authenticate to blip.pl via OAuth.
      #
      # Usage:
      #
      #    use OmniAuth::Strategies::Blip, 'consumerkey', 'consumersecret'
      #
      def initialize(app, consumer_key = nil, consumer_secret = nil, options = {}, &block)
        super(app, :myspace, consumer_key, consumer_secret, { 
          :site => 'http://api.myspace.com',
          :signature_method   => 'HMAC-SHA1',
          :oauth_version => "1.0",
          :http_method => :get,
          :request_token_path => '/request_token',
          :access_token_path => '/access_token',
          :authorize_path => '/authorize' })
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid'       => user_hash['id'].gsub(/[^0-9]/i, "").to_s,
          'user_info' => user_info,
          'extra'     => {'user_hash' => user_hash}
        })
      end

      def user_info
        {
          'nickname'  => user_hash['displayName']
        }
      end

      def user_hash
        @user_hash ||= MultiJson.decode(@access_token.get('/v2/people/@me/@self?format=json').body)["entry"]
      end

    end
  end
end