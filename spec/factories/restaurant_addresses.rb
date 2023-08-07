FactoryBot.define do
  factory :restaurant_address do
    restaurant { nil }
    street { "MyString" }
    address { "MyString" }
    zip_code { "MyString" }
    state { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
  end
end
