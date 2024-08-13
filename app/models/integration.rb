class Integration < ApplicationRecord
  self.primary_key = 'uuid'
  
  belongs_to :user
  has_many :vat_codes
  enum integration_type: { exact_online: 0, salesforce: 1 }
end
