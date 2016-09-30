class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy, :bid]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html, :js

  def index
    if params[:query].present?
      @posts = Post.search(params[:query])
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
     @bid = Bid.new(:post=>@post)
     @most_recent_bid = Bid.joins(:post).where('post_id' => @post).order("created_at").last  
    # Shit don't work
    # @bid = @post.bids.build
    # @most_recent_bid = Bid.joins(:post).where(post_id: params[:id]).most_recent
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params.merge(user_id: current_user.id))
    # Save the post
    if @post.save
      flash[:notice] = 'Post Created'
      redirect_to posts_path
    else
      render :new
    end
  end

  def update
   @post.update(post_params)
   # @post.check_status 
   redirect_to post_path
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post Deleted'
      redirect_to posts_path
    else
      render 'destroy'
    end

  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
      params.require(:post).permit(:title, :description, :price, :when_date)
  end

end
