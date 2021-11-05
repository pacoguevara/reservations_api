FactoryBot.define do
  factory :vehicle do
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model }
    year { Faker::Number.within(range: 2015..2022) }
    customer { nil }
  end
end
