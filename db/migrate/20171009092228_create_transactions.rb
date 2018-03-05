class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :type
      t.references :foundation, type: :uuid, foreign_key: true
      t.decimal :amount

      t.timestamps
    end

    add_index :transactions, :created_at
  end
end
