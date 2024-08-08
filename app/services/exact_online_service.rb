# The ExactOnlineService class provides methods for interacting with desired Exact Online objects.
class ExactOnlineService
  # Initializes a new instance of the InvoicesService class.
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
  def eo_get_vat_codes
    res = @client.get_vat_codes
    handle_get(res)
  end

  # Retrieves all of the customers items that the user has access to
  def eo_customer_items
    res = @client.get_customer_items
    handle_get(res)
  end

  private

  def handle_get(res)
    # update tokens if refreshed
    if res[:token_refreshed]
      @integration.oauth_token = res[:access_token]
      @integration.refresh_token = res[:refresh_token]
      @integration.save!
    end

    # send alert if refresh token is expired
    if res[:refresh_expired]
      return { error: 'Refresh token expired, Please connect again.' }
    end

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
end