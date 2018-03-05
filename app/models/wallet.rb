class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :sent_token_transactions, class_name: "TokenTransaction", foreign_key: "sender_id"
  has_many :received_token_transactions, class_name: "TokenTransaction", foreign_key: "recipient_id"

  def balance
    (received_token_transactions.sum(:amount) - sent_token_transactions.sum(:amount)).round(9).to_f
  end
end
