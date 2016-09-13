class BidsController < ApplicationController

  before_action :set_bid, only: [:show, :edit]
  before_action :set_post, only: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]

  respond_to :html, :js

  def show
  end

  def index
      @bids = Bid.where('post_id' => @post).order("created_at")
  end

  def new
      @bid = Bid.new
  end

  def edit
  end

  def create
    if current_user.id != @post.user_id
        if @post.status == 'open' || @post.status == 'pending'
            @bid = @post.bids.build(bid_params)
            @bid.user = current_user
            # Save the bid
            if @bid.save
                flash[:notice] = 'Bid Placed'
                if @post.status == 'open'
                    @post.status == 'pending'
                end

                if @post.save
                    redirect_to @post
                else
                    flash[:alert] = 'Post status NOT changed'
                end
            else
              flash[:alert] = 'Bid NOT Placed'
          end
      else
          flash[:alert] = 'Not open for bidding'
      end
    else
        flash[:alert] = 'You cannot bid on your own auction'
    end


  end

  private

  def set_bid
      @bid = Bid.find(params[:id])
  end
  def set_post
      @post = Post.find(params[:post_id])
  end

  def bid_params
      params.require(:bid).permit(:amount)
  end

end
