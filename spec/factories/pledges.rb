FactoryGirl.define do
  factory :pledge do
    currency "USD"
    amount 10
    foundation
    user
  end
end
