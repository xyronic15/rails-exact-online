require "omniauth"
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

      # def authorize_params
      #   super.tap do |params|
      #     params[:state] = SecureRandom.hex(24)
      #     session['omniauth.state'] = params[:state]
      #     puts "OmniAuth State Parameter: #{params[:state]}"
      #     session['omniauth.pkce.verifier'] = options.pkce_verifier if options.pkce
      #   end
      # end

      def callback_url
        full_host + script_name + callback_path
      end

      # def callback_phase
      #   # error = request.params["error_reason"] || request.params["error"]
      #   # if error
      #   #   fail!(error, CallbackError.new(request.params["error"], request.params["error_description"] || request.params["error_reason"], request.params["error_uri"]))
      #   # else
      #   #   self.access_token = build_access_token
      #   #   puts "OmniAuth Access Token: #{access_token.token}"
      #   #   puts "OmniAuth Expired: #{access_token.expired?}"
      #   #   self.access_token = access_token.refresh! if access_token.expired?
      #     # super
      #   OmniAuth::Strategy.instance_method(:callback_phase).bind(self).call
      # #   end
      # # rescue ::OAuth2::Error, CallbackError => e
      # #   fail!(:invalid_credentials, e)
      # # rescue ::Timeout::Error, ::Errno::ETIMEDOUT, ::OAuth2::TimeoutError, ::OAuth2::ConnectionError => e
      # #   fail!(:timeout, e)
      # # rescue ::SocketError => e
      # #   fail!(:failed_to_connect, e)
      # end
    end
  end
end