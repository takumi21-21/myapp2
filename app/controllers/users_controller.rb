class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :current_user?, only: [:edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
    @userposts = @user.posts.page(params[:page]).per(8).order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録が完了しました"
      redirect_to @user
    else
      flash.now[:danger] = "登録に失敗しました"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:success] = "更新しました"
      redirect_to @user #user_url(@user)
    else
      flash[:danger] = "更新に失敗しました"
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end


  def current_user?
    if @user = User.find(params[:id])
      unless @user == current_user
        flash[:danger] = "権限がありません"
        redirect_to users_url
      end
    end
  end

end
