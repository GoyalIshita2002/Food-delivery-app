FactoryBot.define do
  factory :restaurant_margin do
    restaurant { nil }
    margin_percent { 1 }
    type { 1 }
  end
end
