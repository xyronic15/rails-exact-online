class User < ApplicationRecord

  has_many :integrations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def add_integration(auth)
    self.integrations.where(integration_type: auth.provider).first_or_initialize.tap do |integration|
      integration.integration_type = auth.provider
      integration.uid = auth.uid
      integration.name = auth.info.name
      integration.email = auth.info.email
      integration.language = auth.extra.language
      integration.org_id = ''
      integration.locale = ''
      integration.timezone = ''
      integration.oauth_token = auth.credentials.token
      integration.refresh_token = auth.credentials.refresh_token
      integration.expires_at = auth.credentials.expires_at
      integration.save!
    end
  end
end
