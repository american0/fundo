class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :pledge, type: :uuid, foreign_key: true
      t.references :foundation, type: :uuid, foreign_key: true
      t.decimal :amount

      t.timestamps
    end

    add_index :payments, :created_at
  end
end
