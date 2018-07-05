FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
    role :dummy
    active true


    factory :user2 do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      password '12345678'
      password_confirmation '12345678'
      role :dummy
      active true
    end
  end
end
