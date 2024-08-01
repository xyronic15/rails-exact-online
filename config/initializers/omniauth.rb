# require "omniauth"
# # require 'strategies/exact_online'
# # require Rails.root.join('lib', 'strategies', 'exact_online')
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :exact_online, ENV['EO_CLIENT_ID'], ENV['EO_CLIENT_SECRET'], {
#     client_options: {
#       site: 'https://start.exactonline.nl',
#       authorize_url: 'https://start.exactonline.nl/api/oauth2/auth',
#       token_url: 'https://start.exactonline.nl/api/oauth2/token'
#     },
#     provider_ignores_state: true
#   }
# end