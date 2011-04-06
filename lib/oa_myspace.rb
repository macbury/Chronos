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
          :site => 'http://api.myspace.com/' ,
          :request_token_path => '/request_token',
          :access_token_path => '/access_token',
          :authorize_path => '/authorize' })
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid'       => user_hash['id'].to_s,
          'user_info' => user_info,
          'extra'     => {'user_hash' => user_hash}
        })
      end

      def user_info
        {
          'nickname'  => user_hash['login'],
          'location'  => user_hash['location'],
          'image'     => image_url
        }
      end

      def user_hash
        @user_hash ||= MultiJson.decode @access_token.get('/v2/people/@me/@self?format=json').body
        puts @user_hash.to_yaml
      end

      def image_url
        @image_url ||= MultiJson.decode(@access_token.get(user_hash['avatar_path']).body)['url'] rescue nil
      end

    end
  end
end