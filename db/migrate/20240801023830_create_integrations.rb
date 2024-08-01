class CreateIntegrations < ActiveRecord::Migration[7.1]
  def change
    create_table :integrations do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }, null: false
      t.belongs_to :user
      t.integer :integration_type
      t.string :uid
      t.string :name
      t.string :email
      t.string :language
      t.string :org_id
      t.string :locale
      t.string :timezone
      t.string :oauth_token
      t.string :refresh_token
      t.integer :expires_at
      t.string :instance_url
      t.timestamps
    end
  end
end
