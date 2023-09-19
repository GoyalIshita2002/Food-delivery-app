FactoryBot.define do
  factory :cart_item do
    cart { nil }
    dish { nil }
    quantity { 1 }
    ordered_price { "9.99" }
  end
end
