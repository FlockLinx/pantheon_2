FactoryBot.define do
  factory :reward do
    association :organization, factory: :organization
    name "Some thing special"
    cost 10
    displaed_cost "10"
    quantity_available 10
    quantity_total 10
    description "lorem ipsum"
  end
end
