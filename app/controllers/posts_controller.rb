class PostsController < ApplicationController
    before_action :require_user_logged_in, only: [:new, :create]
    before_action :correct_user, only: [:destroy]
    
    def index 
        @posts = Post.order(id: :desc).page(params[:page]).per(20)
    end
  
    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)
    
        if @post.save
            flash[:success] = '投稿に成功しました'
            redirect_to '/'
        else
            flash.now[:info] = '投稿に失敗しました'
            render :new
        end
    end

    def destroy
        @post.destroy
        flash[:danger] = "投稿を削除しました"
        redirect_back(fallback_location: root_path)
    end
  
    def tag
        @hashtag = Tag.find_by(hashname: params[:name])
        @post  = @hashtag.posts.order(id: :desc).page(params[:page]).per(20)
    end
  
    private 
  
    def post_params
        params.require(:post).permit(:content, :two_content, :three_content, :four_content, :five_content, :tag_ids, :hashtag, :haiku)
    end
  
    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        unless @post
            redirect_to root_url
        end
    end
end
