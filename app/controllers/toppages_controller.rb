class ToppagesController < ApplicationController
  def index
    if logged_in?
      @posts = Post.all.page(params[:page]).per(9)
    end
  end
end
