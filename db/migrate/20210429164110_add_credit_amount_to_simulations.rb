class AddCreditAmountToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :credit_amount, :integer
  end
end
