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

      # TBD the following items
      # uid { raw_info['id'] }

      # info do {}

      # extra do {}

      # def raw_info
    end
  end
end