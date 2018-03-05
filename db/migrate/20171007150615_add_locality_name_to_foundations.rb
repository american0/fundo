class AddLocalityNameToFoundations < ActiveRecord::Migration[5.1]
  def change
    add_column :foundations, :locality_name, :string
  end
end
