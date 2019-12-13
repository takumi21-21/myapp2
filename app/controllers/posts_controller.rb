class PostsController < ApplicationController


  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :post_user?, only: [:edit, :update, :destroy]


  def index
    @posts = Post.all
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(6).order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = '投稿に成功しました'
      redirect_to posts_url
    else
      flash.now[:danger] = '投稿に失敗しました'
      render 'new'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post = @post.update_attributes(post_params)
      flash[:success] = "投稿を更新しました"
      redirect_to posts_url
    else
      flash.now[:danger] = "投稿の更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:name, :description, :image, :address, :latitude, :longitude, :noodle, :soup)
  end

  def post_user?
    @post = Post.find_by(id: params[:id])
    unless @post.user == current_user
      flash[:danger] = "権限がありません"
      redirect_to posts_url
    end
  end


end
