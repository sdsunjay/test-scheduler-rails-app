class UsersController < ApplicationController
    def index
            #authorize! 
            @users = User.all
        end

    # GET /users/:id.:format
    def show
        @user = User.find(params[:id])
        @user_posts = Post.where('user_id' => @user.id).order(created_at: :desc)
    end
end
