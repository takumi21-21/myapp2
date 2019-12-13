class FavoritesController < ApplicationController

  def index
    @favorite_posts = current_user.favorite_posts.page(params[:page]).per(12).order(created_at: :desc)
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.post_id = params[:post_id]
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
  end

end
