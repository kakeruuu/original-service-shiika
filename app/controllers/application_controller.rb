class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private
    
    def require_user_logged_in
        unless logged_in?
            flash[:info] = 'その操作はログイン時のみ可能です'
            redirect_to login_url
        end
    end
end
