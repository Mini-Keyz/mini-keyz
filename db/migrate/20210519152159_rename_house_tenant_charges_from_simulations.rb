class RenameHouseTenantChargesFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_tenant_charges, :house_tenant_charges_percentage
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
