FactoryBot.define do
  factory :avg_pricing do
    restaurant { nil }
    members { 1 }
    price { 1.5 }
    min_price { 1.5 }
    max_price { 1.5 }
    currency_symbol { "MyString" }
  end
end
