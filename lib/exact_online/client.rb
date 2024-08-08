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

    # bulk GLAccounts retrieval
    # fields include:
    #   Timestamp
    #   AllowCostsInSales
    #   AssimilatedVATBox
    #   BalanceType
    #   BelcotaxType
    #   Code
    #   Description
    #   Division
    #   ExcludeVATListing
    #   ID
    #   PrivatePercentage
    #   Type
    #   VATCode
    #   VATDescription
    def get_gl_accounts
      response = @api.get("/api/v1/#{@division}/sync/Financial/GLAccounts?$select=Timestamp,AllowCostsInSales,AssimilatedVATBox,BalanceType,BelcotaxType,Code,Description,Division,ExcludeVATListing,ID,PrivatePercentage,Type,VATCode,VATDescription")
    end

    # bulk VATCodes retrieval
    # fields include:
    #   ID
    #   Account
    #   AccountCode
    #   AccountName
    #   Code
    #   Country
    #   Description
    #   GLToClaimDescription
    #   GLToPay
    def get_vat_codes
      response = @api.get("/api/v1/#{@division}/vat/VATCodes?$select=ID,Account,AccountCode,AccountName,Code,Country,Description,GLToClaimDescription,GLToPay")
    end

    # bulk CustomerItems retrieval
    # fields include:
    #   Account
    #   AccountCode
    #   AccountName
    #   Created
    #   Creator
    #   CreatorFullName
    #   Division
    #   Item
    def get_customer_items
      response = @api.get("/api/v1/#{@division}/logistics/CustomerItems?$select=Account,AccountCode,AccountName,Created,Creator,CreatorFullName,Division,Item")
    end

    private

  end
end