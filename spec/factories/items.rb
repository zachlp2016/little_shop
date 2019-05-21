FactoryBot.define do
  factory :item do
    user { nil }
    name { "MyString" }
    active { true }
    price { "9.99" }
    description { "MyText" }
    image { "https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg" }
    inventory { 1 }
  end
end
