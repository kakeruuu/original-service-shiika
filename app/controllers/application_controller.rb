class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private
    
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        end
    end
    
    def guest_user
        @user = User.find_by(email: 'guest@example.com')
        if @user == current_user
            flash[:danger] = 'ゲストユーザーは編集・投稿が出来ません'
            redirect_to '/'
        end
    end
end
