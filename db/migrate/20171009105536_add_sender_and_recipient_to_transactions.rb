class AddSenderAndRecipientToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :sender_id, :uuid, foreign_key: true
    add_column :transactions, :recipient_id, :uuid, foreign_key: true

    add_index :transactions, :sender_id
    add_index :transactions, :recipient_id
  end
end
