class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    post.favorite(current_user)
    flash[:success] = 'お気に入りに登録しました'
    redirect_to '/'
  end

  def destroy
    post = Post.find(params[:post_id])
    post.unfavorite(current_user)
    flash[:danger] = 'お気に入りを解除しました'
    redirect_to '/'
  end
end
