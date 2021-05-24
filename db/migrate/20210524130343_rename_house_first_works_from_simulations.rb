class RenameHouseFirstWorksFromSimulations < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulations, :house_first_works, :house_first_works_amount
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
