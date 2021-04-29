class AddAnnualChargesToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_annual_charges, :integer
  end
end
