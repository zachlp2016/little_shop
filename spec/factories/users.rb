FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    role { 1 }
    active { true }
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
  end
end
