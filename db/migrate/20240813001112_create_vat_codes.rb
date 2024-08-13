class CreateVatCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :vat_codes do |t|
      t.string :guid, null: false
      t.belongs_to :integration
      t.string :gl_to_pay
      t.string :description
      t.string :code
      t.string :account_code
      t.string :account

      t.timestamps
    end
  end
end
