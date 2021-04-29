class AddFiscalRegimenToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_regimen, :string
  end
end
