class RenameHousePriceBoughtFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_price_bought, :house_price_bought_amount
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
