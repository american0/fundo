class ChangeBalanceDefaultOnFoundations < ActiveRecord::Migration[5.1]
  def change
    change_column_default :foundations, :balance, from: nil, to: 0
  end
end
