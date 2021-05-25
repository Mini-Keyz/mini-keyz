class RenameHouseAnnualChargesFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_annual_charges, :house_total_charges_amount_per_year
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
