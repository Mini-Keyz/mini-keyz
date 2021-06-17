class AddFiscalNbDependentChildrenToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_nb_dependent_children, :integer
  end
end
