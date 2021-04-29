class AddFiscalStatusDurationToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :fiscal_status_duration, :integer
  end
end
