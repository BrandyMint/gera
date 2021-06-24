class AddIconToGeraPaymentSystems < ActiveRecord::Migration[5.2]
  def change
    rename_column :gera_payment_systems, :icon_url, :icon
  end
end
