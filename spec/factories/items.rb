FactoryBot.define do
  factory :item do
    name { "MyString" }
    price { 1.5 }
    dish_add_on { nil }
  end
end
