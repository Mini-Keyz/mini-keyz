class RenameHouseDelegatedMaintenanceValueFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_delegated_maintenance_value, :house_property_management_cost_percentage
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
