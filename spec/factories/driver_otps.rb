FactoryBot.define do
  factory :driver_otp do
    otp { "MyString" }
    driver { nil }
  end
end
