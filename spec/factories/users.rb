FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'rutabaga'
    full_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  end
end
