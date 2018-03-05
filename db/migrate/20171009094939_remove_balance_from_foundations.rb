class RemoveBalanceFromFoundations < ActiveRecord::Migration[5.1]
  def change
    remove_column :foundations, :balance
  end
end
