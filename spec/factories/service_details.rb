FactoryBot.define do
  factory :service_detail do
    vehicle { 1 }
    locality { "MyText" }
    driver { nil }
  end
end
