class TokenService
  def initialize(foundation)
    @foundation = foundation
  end

  def mint(amount, recipient)
    foundation_token_wallet = @foundation.wallets.where(content_type: 'token').first
    recipient_token_wallet = recipient.wallets.where("content_type = ? AND foundation_id = ?", 'token', @foundation.id).first

    if recipient_token_wallet.nil?
      recipient_token_wallet = Wallet.create(walletable: recipient, content_type: 'token', foundation_id: @foundation.id)
    end
    TokenTransaction.create(type: 'TokenTransaction', amount: amount, recipient_id: recipient_token_wallet.id, sender_id: foundation_token_wallet.id, foundation: @foundation)
  end
end
