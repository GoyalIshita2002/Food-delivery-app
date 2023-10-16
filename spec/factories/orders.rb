FactoryBot.define do
  factory :order do
    customer { nil }
    cart { nil }
    restaurant { nil }
    customer_address { nil }
    status { "MyString" }
  end
end
