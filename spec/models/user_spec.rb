require 'rails_helper'

describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it '有効なファクトリを持つこと' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it '名前、メールアドレス、パスワードがあれば有効な状態であること' do
    user = User.new(
      name: 'Sample User',
      email: 'sample@example.com',
      password: 'password1234'
    )
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe '存在性の検証' do

    it '名前がなければ無効な状態であること' do
      @user.name  = nil
      @user.valid?
      expect(@user.errors).to be_added(:name, :blank)
    end

    it 'メールアドレスがなければ無効な状態であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors).to be_added(:email, :blank)
    end

    it 'パスワードがなければ無効な状態であること' do
      @user.password = @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors).to be_added(:password, :blank)
    end

  end

  describe '一意性の検証' do

    it '重複したメールアドレスなら無効な状態であること' do
      user = FactoryBot.create(:user, email: 'sample@example.com')
      dublicate_user = FactoryBot.build(:user, email: 'sample@example.com')
      dublicate_user.valid?
      expect(dublicate_user.errors).to be_added(:email, :taken, value: 'sample@example.com')
    end

  end

  describe '文字数の検証' do
    it '名前が30文字以内であれば有効であること' do
      @user.name = 'a' * 30
      expect(@user).to be_valid
    end

    it '名前が30文字を超えたら無効' do
      @user.name = 'a' * 31
      @user.valid?
      expect(@user.errors).to be_added(:name, :too_long, count: 30)
    end

    it 'メールアドレスが255以内であれば有効であること' do
      @user.email = 'a' * 243 + '@example.com'
      expect(@user).to be_valid
    end

    it 'メールアドレスが255文字を超えたら無効' do
      @user.email = 'a' * 244 + '@example.com'
      @user.valid?
      expect(@user.errors).to be_added(:email, :too_long, count: 255)
    end

    it 'パスワードが8文字以上32文字以下であれば有効' do
      @user.password = @user.password_confirmation = "a" * 10 + "5" * 20
      expect(@user).to be_valid
    end

    it 'パスワードが8文字以下なら無効' do
      @user.password = @user.password_confirmation = "a" * 4 + "5" * 3
      @user.valid?
      expect(@user.errors).to be_added(:password, :too_short, count: 8)
    end

    it 'パスワードが32文字以上なら無効' do
      @user.password = @user.password_confirmation = "a" * 20 + "5" * 11
      @user.valid?
      expect(@user.errors).to be_added(:password, :too_long, count: 30)
    end

  end

end
