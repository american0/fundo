module ApplicationHelper

  def currency(number)
    ActionController::Base.helpers.number_to_currency(number, unit: "")
  end

end
