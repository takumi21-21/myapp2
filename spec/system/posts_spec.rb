require 'rails_helper'

RSpec.feature "Post", type: :system do
  it "ユーザーは新しい投稿を作成する" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン", match: :first
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"

    expect {
      find('.dropdown-toggle').click　#ドロップダウンのボタンをクリック
      click_link "投稿する"
      fill_in "店名", with: "ブンブンマル"
      attach_file "画像", "app/assets/images/images.png"
      select "太麺", from: "麺の種類"
      select "濃厚", from: "スープの種類"
      fill_in "住所", with: "東京都"
      fill_in "説明文", with: "美味しい"
      click_button "投稿"

      expect(page).to have_content "投稿に成功しました"
      expect(page).to have_content "ブンブンマル"
      expect(page).to have_selector "img"
      expect(page).to have_content "太麺"
      expect(page).to have_content "濃厚"
      expect(page).to have_content "東京都"
      expect(page).to have_content "美味しい"
    }.to change(user.posts, :count).by(1)
  end

  
end
