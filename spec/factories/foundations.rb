FactoryGirl.define do
  factory :foundation do
    country_alpha2 "US"
    local_currency "USD"
    postal_code "11206"
    min_starting_funds 1000
    min_participants 100
    activation_deadline Date.today + 30.days
    latitude Constants::DEFAULT_LAT
    longitude Constants::DEFAULT_LONG
    locality_name "Bushwick"
    address ENV['FAKE_CONTRACT_ADDRESS']
  end

  trait :near_activation do
    min_participants 4
    min_starting_funds 100
    activation_deadline Date.today + 2.days

    after(:create) do |foundation|
      3.times do
        FactoryGirl.create :pledge, foundation: foundation, amount: 25
      end
    end
  end

end
