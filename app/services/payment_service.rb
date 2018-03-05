class PaymentService
  include HTTParty
  attr_reader :pledges

  def initialize(foundation)
    @foundation = foundation
    @pledges = foundation.pledges
  end

  def process_monthly
    @pledges.each do |pledge|
      Payment.create(foundation: pledge.foundation, pledge: pledge, amount: pledge.amount)
    end

    buy_fake_eth(@pledges)
  end

  def buy_fake_eth(pledges)
    price_url = "https://api.coinmarketcap.com/v1/ticker/ethereum/"
    raw_data = HTTParty.get(price_url)
    price = raw_data.parsed_response.first["price_usd"].to_f

    pledges.each do | pledge |
      eth_purchase_amount = pledge.amount.to_f / price
      Transaction.create(type: 'EthTransaction', amount: eth_purchase_amount, foundation: @foundation)
      TokenService.new(@foundation).mint(eth_purchase_amount, pledge.user)
    end
  end
end
