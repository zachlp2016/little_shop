FactoryBot.define do
  factory :order do
    user { nil }
    status { 1 }
    full_address { nil }
    city { nil }
    state { nil }
  end
end
