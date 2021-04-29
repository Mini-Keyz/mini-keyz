class AddCityToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_city, :string
  end
end
