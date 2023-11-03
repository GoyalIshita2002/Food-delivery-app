FactoryBot.define do
  factory :delivery_charge do
    min_distance { 1.5 }
    max_distance { 1.5 }
    charge { 1 }
  end
end
