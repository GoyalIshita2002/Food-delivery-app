FactoryBot.define do
  factory :customer_otp do
    otp { "MyString" }
    customer { nil }
  end
end
