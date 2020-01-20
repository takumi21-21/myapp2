# README

# URL
https://tukemen-myapp.herokuapp.com/posts

つけ麺の画像を投稿し、登録した住所から場所をマップに表示するアプリを作成しました。

# 使用技術
* Ruby 2.5.7, Rails 5.2.3
* heroku
* AWS (S3)
* RSpec
* Bootstrap, JQuery



# 機能一覧
* ユーザー登録・ログイン機能 (ユーザーのプロフィール画像のアップロードにActive Storageを使用)
* twitterログイン（Oauth認証）
* facebookログイン（Oauth認証）
* 画像投稿機能（画像のアップロードにCarrierWave, を使用）
* 登録された住所をマップに表示する機能(Google Apiを使用)
* 住所・地名から位置情報をし取得し移動する（Google Apiを使用）
* 投稿一覧・投稿詳細表示機能
* ページネーション機能（Kaminari）
* いいね機能（Ajax）
* レビュー機能（Ajax）
* 検索機能（Ransackを使用)
