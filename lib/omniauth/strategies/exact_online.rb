require "omniauth"
require 'omniauth-oauth2'

module Omniauth
  module Strategies
    class ExactOnline < OmniAuth::Strategies::OAuth2
      option :name, 'exact_online'

      option :client_options, {
        site: 'https://start.exactonline.nl',
        authorize_url: 'https://start.exactonline.nl/api/oauth2/auth',
        token_url: 'https://start.exactonline.nl/api/oauth2/token'
      }

      # option :pkce, true

      # TBC the following items
      uid { raw_info['feed']['entry']['content']['properties']['user_id']['_content_'] }

      info do
        {
          name: raw_info['feed']['entry']['content']['properties']['full_name'],
          email: raw_info['feed']['entry']['content']['properties']['email'],
          first_name: raw_info['feed']['entry']['content']['properties']['first_name'],
          last_name: raw_info['feed']['entry']['content']['properties']['last_name'],
          image: raw_info['feed']['entry']['content']['properties']['picture_url'],
          phone: raw_info['feed']['entry']['content']['properties']['phone'],
          division: raw_info['feed']['entry']['content']['properties']['current_division']['_content_']
        }
      end

      credentials do
        hash = { token: access_token.token }
        hash.merge!('refresh_token' => access_token.refresh_token) if access_token.refresh_token
        hash
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://start.exactonline.nl/api/v1/current/Me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end

    end
  end
end