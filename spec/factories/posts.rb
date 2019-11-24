FactoryBot.define do
  factory :post do
    description { "MyString" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :user
  end
end
