module ExactOnline
  #  Class defining api methods for interacting with specific objects
  class Client

    def initialize(options = {})
      @api = ExactOnline::API.new(options.except(:division))
      # @integration = integration
      @guid = options[:guid]
      @division = options[:division]
    end

    # TBC random endpoints

    # bulk sales invoice retrieval
    # fields include:
    #   AmountDC
    #   AmountDiscount
    #   AmountDiscountExclVat
    #   AmountFC
    #   Description
    #   Division
    #   DocumentNumber
    #   DocumentSubject,
    #   DueDate
    def get_sales_invoices
      response = @api.get("/api/v1/#{@division}/bulk/SalesInvoice/SalesInvoices?$select=AmountDC,AmountDiscount,AmountDiscountExclVat,AmountFC,Description,Division,DocumentNumber,DocumentSubject,DueDate")
    end

    private

    # def handle_response(response)
    #   if response[:response_data][:status] == 200

    # end


  end
end