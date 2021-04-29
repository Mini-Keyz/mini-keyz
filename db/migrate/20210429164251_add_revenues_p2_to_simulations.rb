class AddRevenuesP2ToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_revenues_p2, :integer
  end
end
