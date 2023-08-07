FactoryBot.define do
  factory :restaurant_menu do
    restaurant { nil }
    min_price { "9.99" }
    max_price { "9.99" }
  end
end
