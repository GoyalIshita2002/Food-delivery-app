FactoryBot.define do
  factory :device do
    device_type { "MyString" }
    device_token { "MyString" }
    customer { nil }
  end
end
