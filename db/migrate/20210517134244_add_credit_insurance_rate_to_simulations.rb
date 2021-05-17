class AddCreditInsuranceRateToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :credit_insurance_rate, :float
  end
end
