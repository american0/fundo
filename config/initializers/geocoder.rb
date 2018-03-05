require 'redis'

uri = URI.parse(ENV["REDISTOGO_URL"])

Geocoder.configure(
  timeout: 10,
  lookup: :google,
  use_https: true,
  api_key: ENV['GOOGLE_API_KEY'],
  cache: Redis.new(:url => uri),
  always_raise: [
    Geocoder::OverQueryLimitError,
    Geocoder::RequestDenied,
    Geocoder::InvalidRequest,
    Geocoder::InvalidApiKey
  ]
)

