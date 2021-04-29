class AddCreditDurationToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :credit_duration, :integer
  end
end
