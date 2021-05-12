class AddHouseNotarialFeesToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_notarial_fees, :float
  end
end
