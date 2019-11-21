class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash.now[:success] = '投稿に成功しました'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました'
      render 'new'
    end
  end


  private

  def post_params
    params.require(:post).permit(:description, :image)
  end

end
