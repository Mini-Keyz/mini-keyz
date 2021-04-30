class AddFiscalStatusToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_status, :string
  end
end
