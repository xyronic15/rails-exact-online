# config/puma/development.rb

# Use SSL and the provided certificate and key
ssl_bind ENV["RAILS_DEVELOPMENT_IP"], '3000', {
  key: Rails.root.join('localhost.key').to_s,
  cert: Rails.root.join('localhost.crt').to_s,
  verify_mode: 'none'
}
