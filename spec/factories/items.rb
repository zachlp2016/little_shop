FactoryBot.define do
  factory :item do
    user { nil }
    name { "MyString" }
    active { false }
    price { "9.99" }
    description { "MyText" }
    image { "MyString" }
    inventory { 1 }
  end
end
