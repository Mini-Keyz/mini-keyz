class AddPropertyTaxToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_property_tax, :integer
  end
end
