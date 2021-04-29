class AddFiscalNberPartsToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_nb_parts, :float
  end
end
