require 'faraday'
require 'json'

module ExactOnline

  autoload :Client, 'exact_online/client'
  autoload :API, 'exact_online/api'

  class << self
    # alias for ExactOnline::Client.new

    def new(options)
      ExactOnline::Client.new(options)
    end
  end
end