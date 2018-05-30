FactoryBot.define do
  factory :employment do
    association :user, factory: :user
    association :organization, factory: :organization
  end
end
