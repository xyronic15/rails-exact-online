require "omniauth"
# require 'strategies/exact_online'
# require Rails.root.join('lib', 'strategies', 'exact_online')
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :exact_online, ENV['EO_CLIENT_ID'], ENV['EO_CLIENT_SECRET']
end