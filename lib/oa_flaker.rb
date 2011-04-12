require 'omniauth'
require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Flaker < OAuth

      def initialize(app, consumer_key = nil, consumer_secret = nil, options = {}, &block)
        super(app, :flaker, consumer_key, consumer_secret, { 
          :site => 'http://flaker.pl',
          :signature_method   => 'HMAC-SHA1',
          :oauth_version => "1.0",
          :http_method => :get,
          :request_token_path => '/oauth/request_token',
          :access_token_path => '/oauth/access_token',
          :authorize_path => '/oauth/authorize' })
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'user_info' => user_info,
          'extra'     => {'user_hash' => user_hash}
        })
      end

      def user_info
        {
          'nickname'  => user_hash['user']['login']
        }
      end

      def user_hash
        @user_hash ||= MultiJson.decode @access_token.get('http://api.flaker.pl/api/type:user').body
      end
    end
  end
end
