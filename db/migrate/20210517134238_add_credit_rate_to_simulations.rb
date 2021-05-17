class AddCreditRateToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :credit_rate, :float
  end
end
