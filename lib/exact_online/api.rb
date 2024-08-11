require 'faraday'
require 'json'

module ExactOnline
  # Class for general API calls
  class API
    AUTH_PATH = '/api/oauth2/auth'
    TOKEN_PATH = '/api/oauth2/token'

    def initialize(options = {})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @instance_url = options[:instance_url]
      @access_token = options[:access_token]
      @refresh_token = options[:refresh_token]
      @token_refreshed = false
      @refresh_expired = false
      @refresh_attempts = 0
    end

    def get(path, params = {})
      response = connection.get(path, params)
      handle_response(response, response.status)
    rescue Faraday::Error => e
      handle_error(e)
    end

    def post(path, data = {})
      response = connection.post(path, data.to_json)
      handle_response(response, response.status)
    rescue Faraday::Error => e
      handle_error(e)
    end

    def put(path, data = {})
      response = connection.put(path, data.to_json)
      handle_response(response, response.status)
    rescue Faraday::Error => e
      handle_error(e)
    end

    def delete(path)
      response = connection.delete(path)
      handle_response(response, response.status)
    rescue Faraday::Error => e
      handle_error(e)
    end

    private

    def token_url
      "#{@instance_url}#{TOKEN_PATH}"
    end

    def connection
      @connection ||= Faraday.new(url: @instance_url,  headers: {'Content-Type' => 'application/json'}) do |builder|
        builder.request :authorization, 'Bearer', -> { @access_token }
        builder.request :json
        # builder.response :json, content_type: /\bjson$/
        builder.response :json
        builder.response :raise_error
        builder.adapter Faraday.default_adapter
      end
    end

    def handle_response(response, status)
      {
        access_token: @access_token,
        refresh_token: @refresh_token,
        token_refreshed: @token_refreshed,
        refresh_expired: @refresh_expired,
        status: status,
        response_data: response
      }.tap do
        @token_refreshed = false
      end
    end

    def handle_error(e)
      puts "Error: #{e.message}"
      puts "Body: #{e.response}"
      if e.response[:status] == 401
        refresh_response = refresh_token!
        return refresh_response unless @token_refreshed
        puts "Retrying request..."
        reponse = retry_request(e.response)
      else
        handle_response(e.response, e.response[:status])
      end
    end

    def refresh_token!
      conn = Faraday.new(url: @instance_url) do |builder|
        builder.request :url_encoded
        builder.response :json, content_type: /\bjson$/
        builder.response :raise_error, include_request:true
        builder.adapter Faraday.default_adapter
      end

      response = conn.post(TOKEN_PATH, {
        grant_type: 'refresh_token',
        refresh_token: @refresh_token,
        client_id: @client_id,
        client_secret: @client_secret
      })

      if response.success?
        data = response.body
        puts "data: #{data}"
        @access_token = data['access_token']
        @refresh_token = data['refresh_token']
        @token_refreshed = true
        @refresh_expired = false
        puts "Token refreshed #{@token_refreshed}"
        @refresh_attempts = 0
        return
      end

      rescue Faraday::Error => e
        @refresh_attempts += 1
        retry if @refresh_attempts < 5
        @refresh_expired = true
        puts "Error: #{e.message}"
        puts "Body: #{e.response}"
        handle_response(e.response, e.response[:status])
    end

    def retry_request(error)
      # puts "Retry Body: #{error[:request][:body].class}"
      # puts "Retry Params: #{error[:request][:params].presence}"
      response = connection.send(error[:request][:method], error[:request][:url_path]) do |request|
        request.body = error[:request][:body]
        request.params = error[:request][:params] || {}
      end

      handle_response(response, response.status)
    rescue Faraday::Error => e
      puts "Error: #{e.message}"
      puts "Body: #{e.response}"
      handle_response(e.response, e.response[:status])
    end
    
  end
end