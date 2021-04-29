class AddRentPerMonthToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_rent_per_month, :integer
  end
end
