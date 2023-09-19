FactoryBot.define do
  factory :cart do
    customer { nil }
    total_amount { "9.99" }
    item_count { 1 }
    status { 1 }
  end
end
