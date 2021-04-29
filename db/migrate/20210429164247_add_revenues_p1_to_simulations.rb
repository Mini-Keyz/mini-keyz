class AddRevenuesP1ToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_revenues_p1, :integer
  end
end
