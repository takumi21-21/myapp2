class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :current_user?, only: [:edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find_by(id: params[:id])
    @userposts = @user.posts.page(params[:page]).per(6)
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
      flash.now[:danger] = "更新に失敗しました"
      render 'edit'
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
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      flash[:danger] = "権限がありません"
      redirect_to users_url
    end
  end

end
