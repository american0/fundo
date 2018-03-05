class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_location
    return request.location if request.location.latitude != 0.0

    request.location.data["latitude"] = Constants::DEFAULT_LAT
    request.location.data["longitude"] = Constants::DEFAULT_LONG
    return request.location
  end
end
