require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  def log_in(user)
    session[:user_id] = user.id
  end

  describe "newアクション" do
    context "ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
      end
      it "新規登録ページにアクセスできること" do
        get :new
        expect(response).to be_success
      end
    end

    context "未ログインユーザー" do
      it '新規投稿ページにアクセスすると、ログインページに遷移すること' do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "createアクション" do

    context "ログインユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
      end

      it "投稿を追加できること" do
        post_params = FactoryBot.attributes_for(:post)
        expect {
          post :create, params: { post: post_params }
        }.to change(@user.posts, :count).by(1)
      end
    end

    context "未ログインユーザー" do
      it "302レスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end

      it "ログイン画面に遷移すること" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "updateアクション" do
    context "ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        log_in @user
      end

      it "投稿を更新できること" do
        post_params = FactoryBot.attributes_for(:post, name: "ブンブンマル")
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.name).to eq "ブンブンマル"
      end

    end

    context "他のユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @other_user, name: "マンモス")
        log_in @user
      end

      it "プロジェクトを更新できないこと" do
        post_params = FactoryBot.attributes_for(:post, name: "ブンブンマル")
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.name).to eq "マンモス"
      end

      it "投稿一覧に遷移すること" do
        post_params = FactoryBot.attributes_for(:post, name: "ブンブンマル")
        patch :update, params: { id:@post.id, post: post_params }
        expect(response).to redirect_to posts_url
      end
    end

    context "未ログインユーザー" do
      before do
        @post = FactoryBot.create(:post)
      end

      it "302レスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to have_http_status "302"
      end

      it "ログイン画面に遷移する" do
        post_params = FactoryBot.attributes_for(:post)
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "destoryアクション" do

    context "ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        log_in @user
      end

      it "プロジェクトを削除できること" do
        expect{
          delete :destroy, params: { id: @post.id }
        }.to change(@user.posts, :count).by(-1)
      end
    end

    context "他のユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @other_user)
        log_in @user
      end

      it "投稿を削除できないこと" do
        expect {
          delete :destroy, params: { id: @post.id }
        }.to change(@other_user.posts, :count).by(0)
      end

      it "投稿一覧ページにリダイレクトする" do
        delete :destroy, params: { id: @post.id }
        expect(response).to redirect_to posts_url
      end
    end

    context "未ログインユーザー" do
      before do
        @post = FactoryBot.create(:post)
      end

      it "302レスポンスを返すこと" do
        delete :destroy, params: { id: @post.id }
        expect(response).to have_http_status "302"
      end

      it "ログイン画面にリダイレクトする" do
        delete :destroy, params: { id: @post.id }
        expect(response).to redirect_to login_url
      end

      it "プロジェクトを削除できないこと" do
        expect {
          delete :destroy, params: { id: @post.id }
        }.to_not change(Post, :count)
      end

    end
  end
end
