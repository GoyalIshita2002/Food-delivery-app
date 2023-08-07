FactoryBot.define do
  factory :dish do
    name { "MyString" }
    type { 1 }
    price { "9.99" }
    description { "MyText" }
    restaurant_menu { nil }
  end
end
