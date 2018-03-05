class GeocoderService
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def fetch_locality
    locality_types = [:neighborhood, :sublocality, :city]
    results = Geocoder.search("#{latitude},#{longitude}")
    locality_types.each do |type|
      locality = get_address_component(results, type)
      return locality if locality.present?
    end
  end

  private

  def get_address_component(results, component_type)
    filtered_results = results.select { |r| r.address_components_of_type(component_type).present? }
    if filtered_results.any?
      filtered_results.first.address_components_of_type(component_type).first['short_name']
    end
  end

end
