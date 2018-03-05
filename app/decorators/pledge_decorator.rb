class PledgeDecorator
  attr_reader :pledge

  def initialize(pledge)
    @pledge = pledge
  end

  def total
    if is_initial_pledge?
      @pledge.amount + Constants::INITIAL_GAS_USD
    else
      @pledge.amount
    end
  end

  def active?
    pledge.foundation.status == "Active"
  end

  def is_initial_pledge?
    @pledge == @pledge.foundation.pledges.first
  end

end
