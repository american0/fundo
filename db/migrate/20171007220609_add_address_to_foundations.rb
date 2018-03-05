class AddAddressToFoundations < ActiveRecord::Migration[5.1]
  def change
    add_column :foundations, :address, :string
  end
end
