class AddFirstWorksToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :house_first_works, :integer
  end
end
