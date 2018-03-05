class HomeController < ApplicationController
  def index
    @location = set_location
  end

end

