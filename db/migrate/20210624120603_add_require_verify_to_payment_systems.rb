class AddRequireVerifyToPaymentSystems < ActiveRecord::Migration[5.2]
  def change
    add_column :gera_payment_systems, :require_verify, :boolean, null: false, default: false
  end
end
