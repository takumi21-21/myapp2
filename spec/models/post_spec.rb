require 'rails_helper'

describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }

  it '有効なファクトリを持つ' do
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

   it '住所がなければ無効なこと' do
     post.address = nil
     post.valid?
     expect(post.errors).to be_added(:address, :blank)
   end

   it '店名がなければ無効なこと' do
     post.name = nil
     post.valid?
     expect(post.errors).to be_added(:name, :blank)
   end

   it '麺の種類がなければ無効なこと' do
     post.noodle = nil
     post.valid?
     expect(post.errors).to be_added(:noodle, :blank)
   end

   it 'スープの種類がなければ無効なこと' do
     post.soup = nil
     post.valid?
     expect(post.errors).to be_added(:soup, :blank)
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
