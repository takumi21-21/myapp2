require 'rails_helper'

describe 'ポスト管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:post, description: '最初のポスト', user: user_a)
    end

    context 'ユーザーAがログインしている時' do
      before do
        visit login_path
        fill_in 'session_email', with: 'a@example.com'
        fill_in 'session_password', with: 'password5151'
        click_button 'ログイン'
      end

      it 'ユーザーAが作成したポストが表示される' do
        visit posts_path
        expect(page).to have_content '最初のポスト'
      end

    end
  end
end
