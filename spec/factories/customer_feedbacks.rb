FactoryBot.define do
  factory :customer_feedback do
    order { nil }
    title { "MyString" }
    description { "MyString" }
    status { 1 }
  end
end
