class AddPriceBoughtToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_price_bought, :integer
  end
end
