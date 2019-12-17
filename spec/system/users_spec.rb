require 'rails_helper'

RSpec.describe "Users", type: :system do
  it '新しいユーザーを作成する' do
    visit root_path

    expect {
      click_link "新規登録"
      fill_in "名前", with: "takumi"
      attach_file "プロフィール画像", "app/assets/images/images.png"
      fill_in "メールアドレス", with: "takumi@example.com"
      fill_in "パスワード", with: "foobar5151"
      fill_in "パスワード確認", with: "foobar5151"
      click_button "登録"

      expect(page).to have_content "登録が完了しました"
      expect(page).to have_content "takumi"
      expect(page).to have_selector "img"
      expect(page).to have_content "編集"
      expect(page).to have_content "削除"
    }.to change(User, :count).by(1)
  end
end
