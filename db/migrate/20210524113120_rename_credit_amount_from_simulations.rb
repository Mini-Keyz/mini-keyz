class RenameCreditAmountFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :credit_amount, :credit_loan_amount
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
