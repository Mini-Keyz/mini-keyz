class RenameHouseInsuranceGliAnnualCostFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_insurance_gli_annual_cost, :house_insurance_gli_percentage
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
