class AddBalanceToFoundations < ActiveRecord::Migration[5.1]
  def change
    add_column :foundations, :balance, :decimal
  end
end
