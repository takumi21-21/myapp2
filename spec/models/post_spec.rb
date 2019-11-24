require 'rails_helper'

describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }

  it '有効なファクトリを持つ' do
    expect(post).to be_valid
  end

 it 'ユーザー、画像、説明文があれば有効' do
   user = FactoryBot.create(:user)
   post = Post.new(
    image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')),
    user: user,
    description: 'MyString'
   )
   expect(post).to be_valid
 end

 describe '存在性の検証' do

   it '画像がなければ無効なこと' do
     post.image = nil
     post.valid?
     expect(post.errors).to be_added(:image, :blank)
   end

   it 'ユーザーがなければ無効なこと' do
     post.user = nil
     post.valid?
     expect(post.errors).to be_added(:user, :blank)
   end

   it '説明文がなければ無効なこと' do
     post.description = nil
     post.valid?
     expect(post.errors).to be_added(:description, :blank)
   end

 end

 describe '文字数の検証' do
   it '説明文が240文字以内であれば有効' do
     post.description = 'a' * 240
     expect(post).to be_valid
   end

   it '説明文が240文字を超えたら無効' do
     post.description = 'a' * 241
     post.valid?
     expect(post.errors).to be_added(:description, :too_long, count: 240)
   end
 end


end
