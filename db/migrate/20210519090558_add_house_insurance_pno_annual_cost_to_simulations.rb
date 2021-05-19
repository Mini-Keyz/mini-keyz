class AddHouseInsurancePnoAnnualCostToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_insurance_pno_annual_cost, :float
  end
end
