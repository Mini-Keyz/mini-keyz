class RenameHouseInsurancePnoAnnualCostFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_insurance_pno_annual_cost, :house_insurance_pno_amount_per_year
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
