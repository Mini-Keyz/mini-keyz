class RenameHouseRentPerMonthFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_rent_per_month, :house_rent_amount_per_month
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
