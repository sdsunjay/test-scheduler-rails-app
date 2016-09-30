class BidsController < ApplicationController

  before_action :set_bid, only: [:show, :edit]
  before_action :set_post, only: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]

  respond_to :html, :js

  def show
  end

  def index
      @bids = Bid.where(post_id: @post.id).order(:created_at)
  end

  def new
      @bid = Bid.new
  end

  def edit
  end

  def create 
      if current_user.id != @post.user_id
        if @post.open? || @post.pending?
            @bid = @post.bids.build(bid_params.merge(user_id: current_user.id))
            # Save the bid
            if @bid.save
                flash[:notice] = 'Bid Placed'
                if @post.status == 'open'
                    @post.status = 'pending'
                    @post.save
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
    redirect_to @post
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
