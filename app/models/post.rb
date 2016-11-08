class Post < ActiveRecord::Base
    belongs_to :user    
    has_many :bids
    
    validates :user_id, presence: true
    validates :title, presence: {message: 'The auction must have a title'}
    validates :price, presence: {message: 'The item must have a starting price'}
    validates_numericality_of :price 
    validates_uniqueness_of :title
    validates :when_date, presence: {message: 'End date and time cannot be blank'}

    def check_highest_bid
        highest_bid = self.bids.order("amount DESC").first.amount rescue 0
        self.price = highest_bid
        save
    end

    enum status: {
        # The post is available for bids
        open: 0,
        # The post has one or more bids
        pending: 1,
        # More than 0 bids and the auction has end
        complete: 2,
        # No bids and the auction is over
        incomplete: 3
    }

    def update_status
        if pending? && when_date < DateTime.now
            # More than 0 bids and the auction has ended
            self.complete!
        elsif open? && when_date < DateTime.now  
            # 0 bids and the auction has ended
            self.incomplete!
        end
    end

    def is_auction_complete
        return self.status == 'complete'
    end
end
