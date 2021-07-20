class AddFiscalNbAlternateCustodyChildrenToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_nb_alternate_custody_children, :integer
  end
end
