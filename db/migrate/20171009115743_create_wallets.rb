class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets, id: :uuid do |t|
      t.string :walletable_type
      t.uuid :walletable_id

      t.timestamps
    end
  end
end
