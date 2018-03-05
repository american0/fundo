class EthereumService
  attr_reader :foundation

  def initialize(foundation)
    @foundation = foundation
  end

  def deploy_contract
    if foundation.address.nil?
      foundation.update(address: ENV['FAKE_CONTRACT_ADDRESS'])
    else
      return false
    end
  end
end
