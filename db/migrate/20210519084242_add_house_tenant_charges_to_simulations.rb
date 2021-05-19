class AddHouseTenantChargesPercentageToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_tenant_charges, :float
  end
end
