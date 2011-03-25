require 'omniauth'
require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Flaker < OAuth

      def initialize(app, consumer_key = nil, consumer_secret = nil, options = {}, &block)
        super(app, :flaker, consumer_key, consumer_secret, { :site => 'http://flaker.pl' })
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
        @user_hash ||= MultiJson.decode @access_token.get('/api/type:user').body
      end
    end
  end
end