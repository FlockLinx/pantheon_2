FactoryBot.define do
  factory :organization do
     association :owner, factory: :user
     trading_name { Faker::Name.name }
     organization_tags []
     stars_by_month 20
  end
end
