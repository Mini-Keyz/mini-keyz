class AddHouseDelegatedMaintenanceValueToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_delegated_maintenance_value, :float
  end
end
