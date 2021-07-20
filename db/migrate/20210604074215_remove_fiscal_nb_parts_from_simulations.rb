class RemoveFiscalNbPartsFromSimulations < ActiveRecord::Migration[6.1]
  def change
    remove_column :simulations, :fiscal_nb_parts
  end
end
