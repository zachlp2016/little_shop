FactoryBot.define do
  factory :user do
    password_digest { "MyString" }
    role { 1 }
    active { true }
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    sequence :email do |n|
      "person#{n}@example.com"
    end
  end
end
