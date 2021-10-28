class AddSlugToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :slug, :string
    add_index :simulations, :slug, unique: true
  end
end
