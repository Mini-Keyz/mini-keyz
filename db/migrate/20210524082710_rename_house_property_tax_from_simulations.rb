class RenameHousePropertyTaxFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_property_tax, :house_property_tax_amount_per_year
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
