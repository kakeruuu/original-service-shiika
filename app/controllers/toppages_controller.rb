class ToppagesController < ApplicationController
  def index
    if logged_in?
      @posts = Post.order(id: :desc).page(params[:page]).per(20)
    end
  end
end
