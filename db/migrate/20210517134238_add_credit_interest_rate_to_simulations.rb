class AddCreditInterestRateToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :credit_interest_rate, :float
  end
end
