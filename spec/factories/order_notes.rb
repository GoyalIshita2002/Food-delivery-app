FactoryBot.define do
  factory :order_note do
    content { "MyText" }
    order { nil }
  end
end
