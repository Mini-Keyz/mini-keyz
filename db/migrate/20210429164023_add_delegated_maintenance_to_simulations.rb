class AddDelegatedMaintenanceToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_delegated_maintenance, :boolean
  end
end
