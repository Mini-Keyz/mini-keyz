class RenameCreditInterestRateFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :credit_interest_rate, :credit_loan_interest_percentage_per_year
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
