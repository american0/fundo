class CreatePledges < ActiveRecord::Migration[5.1]
  def change
    create_table :pledges, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :foundation, type: :uuid, foreign_key: true
      t.string :address
      t.decimal :amount, precision: 11, scale: 2
      t.string :currency
      t.datetime :cancelled_at
    end

  end
end
