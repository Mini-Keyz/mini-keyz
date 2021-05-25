class RenameCreditDurationFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :credit_duration, :credit_loan_duration
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
