FactoryBot.define do
  factory :dish_add_on do
    name { "MyString" }
    min_quantity { 1 }
    max_quantity { 1 }
    restaurant { nil }
  end
end
