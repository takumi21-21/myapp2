FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email)    { |n| "sample#{n}@example.com" }
    password { 'password5151' }
  end

end
