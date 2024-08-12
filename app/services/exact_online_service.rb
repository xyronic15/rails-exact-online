# The ExactOnlineService class provides methods for interacting with desired Exact Online objects.
class ExactOnlineService
  # Initializes a new instance of the ExactOnlineService class.
  # 
  # @param integration [Integration] The Exact Online integration
  def initialize(integration)
    @integration = integration
    options = {
      client_id: ENV['EO_CLIENT_ID'],
      client_secret: ENV['EO_CLIENT_SECRET'],
      instance_url: ENV['EO_INSTANCE_URL'],
      access_token: @integration.oauth_token,
      refresh_token: @integration.refresh_token,
      guid: @integration.uid,
      division: @integration.org_id
    }
    @client = ExactOnline.new(options)
  end

  # get methods

  # Retrieves all of the invoices that the user has access to
  def eo_get_sales_invoices
    res = @client.get_sales_invoices
    handle_get(res)
  end

  # Retrieves all of the GL accounts that the user has access to
  def eo_get_gl_accounts
    res = @client.get_gl_accounts
    handle_get(res)
  end

  # Retrieves all of the VAT codes that the user has access to
  def eo_get_all_vat_codes
    res = @client.get_all_vat_codes
    handle_get(res)
  end

  # Retrieves a specific VAT code by its ID
  # 
  # @param id [String] The ID of the VAT code to retrieve
  def eo_get_vat_code(id)
    res = @client.get_vat_code(id)
    handle_get(res)
  end

  # Retrieves all of the customers items that the user has access to
  def eo_customer_items
    res = @client.get_customer_items
    handle_get(res)
  end

  # post methods

  # Creates a new VAT code
  #
  # @param data [Hash] The data for the new VAT code
  def eo_post_vat_code(data)
    res = @client.post_vat_code(data)
    handle_post(res)
  end

  # put methods

  # Updates an existing VAT code
  # 
  # @param id [String] The ID of the VAT code to update
  # @param data [Hash] The updated data for the VAT code
  def eo_put_vat_code(id, data)
    res = @client.put_vat_code(id, data)
    handle_put_delete(res)
  end

  #  delete methods

  # Deletes an existing VAT code
  # 
  # @param id [String] The ID of the VAT code to delete
  def eo_delete_vat_code(id)
    res = @client.delete_vat_code(id)
    handle_put_delete(res)
  end

  private

  def check_refresh?(res)
    # update tokens if refreshed
    if res[:token_refreshed]
      @integration.oauth_token = res[:access_token]
      @integration.refresh_token = res[:refresh_token]
      return @integration.save!
    end

    # return false if refresh token is expired
    return false if res[:refresh_expired]

    # return true if nothing needs to be done
    true
  end

  # Handles GET requests
  # 
  # @param res [Hash] The response from the Exact Online Client
  # @return [Hash] The response data or error
  def handle_get(res)
    # check the refresh token
    # send alert if refresh token is expired
    return { error: 'Refresh token expired, Please connect again.' } unless check_refresh?(res)

    # handle the response
    if res[:status] == 200
      body = Hash.from_xml(res[:response_data].body)
      return { data: body['feed']['entry'] }
    else
      {
        error: res[:response_data][:body],
        status: res[:status]
      }
    end
  end

  # Handles POST requests
  #
  # @param res [Hash] The response from the Exact Online Client
  # @return [Hash] The response data or error
  def handle_post(res)
    # check the refresh token
    # send alert if refresh token is expired
    return { error: 'Refresh token expired, Please connect again.' } unless check_refresh?(res)

    # handle the response
    if res[:status] == 201
      body = Hash.from_xml(res[:response_data].body)
      return { data: body['entry'] }
    else
      {
        error: res[:response_data][:body],
        status: res[:status]
      }
    end
  end

  # Handles PUT and DELETE requests
  #
  # @param res [Hash] The response from the Exact Online Client
  # @return [Hash] The response data or error
  def handle_put_delete(res)
    # check the refresh token
    # send alert if refresh token is expired
    return { error: 'Refresh token expired, Please connect again.' } unless check_refresh?(res)

    # handle the response
    if res[:status] == 204
      return { data: 'Success' }
    else
      {
        error: res[:response_data][:body],
        status: res[:status]
      }
    end
  end

end