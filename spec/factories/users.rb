# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { 'Leonardo' }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { 'user' }
    active { true }
    nickname { 'Leonardo' }

    trait :admin do
      role { 'admin' }
    end

    trait :inactive do
      active { false }
    end

    trait :with_external_id do
      external_id { Faker::Number.unique.number(digits: 6) }
    end
  end
end