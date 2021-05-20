class RenameHouseNotarialFeesFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_notarial_fees, :house_notarial_fees_percentage
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
