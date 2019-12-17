class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to post_path(@review.post)
    else
      flash[:danger] = "レビューの投稿に失敗しました。"
      redirect_to post_path(@review.post)
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    review = Review.find_by(post_id: post.id, user_id: current_user.id)
    review.destroy
    flash[:success] = "レビューを削除しました。"
    redirect_to post_path(id: post.id)
  end



  private

  def review_params
    params.require(:review).permit(:user_id, :post_id, :content, :rate)
  end
end
