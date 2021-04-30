class AddUserReferenceToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_reference :simulations, :user, foreign_key: true
  end
end
