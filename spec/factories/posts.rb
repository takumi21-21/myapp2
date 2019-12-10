FactoryBot.define do
  factory :post do
    description { "MyString" }
    name { "マンモス" }
    address { "Tokyo" }
    noodle { "極太麺" }
    soup { "濃厚" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :user
  end
end
