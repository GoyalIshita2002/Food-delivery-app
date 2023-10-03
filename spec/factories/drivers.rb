FactoryBot.define do
  factory :driver do
    full_name { "MyString" }
    dob { "2023-10-03" }
    email { "MyString" }
    address { "MyText" }
    phone { "MyString" }
    std_code { "MyString" }
    is_verified { false }
  end
end
