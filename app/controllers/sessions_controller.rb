class SessionsController < ApplicationController

  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_form_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      flash[:success] = "ユーザー認証が完了しました。"
      redirect_to user
    else
      @user = User.find_by(email: params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        log_in @user
        flash[:success] = "ログインしました"
        redirect_to @user
      else
        flash.now[:danger] = "ログインに失敗しました"
        render 'new'
      end
    end
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end

end
