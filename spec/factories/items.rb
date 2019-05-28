FactoryBot.define do
  factory :item do
    user { nil }
    sequence :name do |n|
      "Cheese #{n}"
    end
    active { true }
    price { 20 }
    description { "MyText" }
    image { "https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg" }
    inventory { 100 }
  end
end
