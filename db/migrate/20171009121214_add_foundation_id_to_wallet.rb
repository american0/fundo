class AddFoundationIdToWallet < ActiveRecord::Migration[5.1]
  def change
    add_column :wallets, :foundation_id, :uuid
    add_column :wallets, :content_type, :string
  end
end
