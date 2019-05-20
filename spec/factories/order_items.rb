FactoryBot.define do
  factory :order_item do
    item { nil }
    order { nil }
    quantity { 1 }
    price { "9.99" }
    fulfilled { false }
  end
end
