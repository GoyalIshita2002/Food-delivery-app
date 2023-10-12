FactoryBot.define do
  factory :service_location do
    address { "MyString" }
    street { "MyString" }
    state { "MyString" }
    country { "MyString" }
    vehicle { 1 }
    latitude { "9.99" }
    longitude { "9.99" }
    vehicle { 1 }
    driver { nil }
  end
end
