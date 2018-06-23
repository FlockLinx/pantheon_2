FactoryBot.define do
  factory :post do
    cause Faker::StarWars.quote
    star_amount 10
  end
end
