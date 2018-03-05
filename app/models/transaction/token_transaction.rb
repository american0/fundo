class TokenTransaction < Transaction
  belongs_to :sender, class_name: 'Wallet'
  belongs_to :recipient, class_name: 'Wallet'
end
