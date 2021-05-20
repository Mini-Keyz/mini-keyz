class RenameCreditInsuranceRateFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :credit_insurance_rate, :credit_loan_insurance_percentage_per_year
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
