FactoryBot.define do
  factory :review do
    content { "MyString" }
    rate { 1.5 }
    user { nil }
  end
end
