require 'rails_helper'
RSpec.describe UsersController, type: :controller do

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  describe "editアクション" do
    context "ログインユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
      end

      it "編集ページにアクセスできること" do
        get :edit, params: { id: @user.id }
        expect(response).to be_success
      end
    end

    context "他のユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        log_in @user
      end

      it "ユーザー編集画面にアクセスするとログイン画面に遷移すること" do
        get :edit, params: { id: @other_user.id }
        expect(response).to redirect_to users_url
      end
    end

    context "未ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "ユーザー編集ページにアクセスするとログインページに遷移すること" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "updateアクション" do
    context "ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
      end
      it "ユーザーを更新できること" do
        user_params = FactoryBot.attributes_for(:user, name: "takumi")
        patch :update, params: { id: @user.id, user: user_params}
        expect(@user.reload.name).to eq "takumi"
      end
    end

    context "他のユーザー" do
      before  do
        @user = FactoryBot.create(:user, name: "takumi")
        @other_user = FactoryBot.create(:user, name: "takashi")
        log_in @user
      end

      it "ユーザーを更新できないこと" do
        user_params = FactoryBot.attributes_for(:user)
        patch :update, params: { id: @other_user, user: user_params}
        expect(@other_user.reload.name).to eq "takashi"
      end

      it "ユーザー一覧ページに遷移すること" do
        user_params = FactoryBot.attributes_for(:user)
        patch :update, params: { id: @other_user, user: user_params}
        expect(response).to redirect_to users_url
      end
    end

    context "未ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "302レスポンスを返すこと" do
        user_params = FactoryBot.attributes_for(:user)
        patch :update, params: { id: @user, user: user_params }
        expect(response).to have_http_status "302"
      end

      it "ログインページに遷移すること" do
        user_params = FactoryBot.attributes_for(:user)
        patch :update, params: { id: @user, user: user_params }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "destroyアクション" do
    context "ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        log_in @user
      end

      it "ユーザーを削除できること" do
        expect{
          delete :destroy, params: { id: @user.id }
        }.to change(User, :count).by(-1)
      end
    end
    context "他のユーザー" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        log_in @user
      end

      it "ユーザーを削除できないこと" do
        expect{
          delete :destroy, params: { id: @other_user.id }
        }.to change(User, :count).by(0)
      end

      it "ユーザー一覧ページにリダイレクトされる" do
        delete :destroy, params: { id: @other_user.id }
        expect(response).to redirect_to users_url
      end
    end

    context "未ログインユーザー" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "302レスポンスを返す" do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "ログインページに遷移する" do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to login_url
      end

      it "ユーザーを削除できないこと" do
        expect{
          delete :destroy, params: { id: @other_user.id }
        }.to change(User, :count).by(0)
      end
    end
  end
end
