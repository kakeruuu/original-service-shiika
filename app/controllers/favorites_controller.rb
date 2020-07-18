class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    post.favorite(current_user)
    post.reload
    flash[:success] = 'お気に入りに登録しました'
    redirect_to user_path(current_user)
  end

  def destroy
    post = Post.find(params[:post_id])
    post.unfavorite(current_user)
    post.reload
    flash[:danger] = 'お気に入りを解除しました'
    redirect_to user_path(current_user)
  end
end
