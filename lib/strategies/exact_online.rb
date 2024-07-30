require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class ExactOnline < OmniAuth::Strategies::OAuth2
      option :name, 'exact_online'

      option :client_options, {
        site: 'https://start.exactonline.nl',
        authorize_url: 'https://start.exactonline.nl/api/oauth2/auth',
        token_url: 'https://start.exactonline.nl/api/oauth2/token'
      }

      # TBC the following items
      uid { raw_info['UserID'] }

      info do
        {
          name: raw_info['FullName'],
          email: raw_info['Email'],
          image: raw_info['Avatar']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://start.exactonline.nl/api/v1/current/Me').parsed
      end
    end
  end
end