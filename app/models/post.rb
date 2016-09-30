class Post < ActiveRecord::Base
    belongs_to :user    
    validates :user_id, presence: true
    validates :title, presence: {message: 'The auction must have a title'}
    validates :price, presence: {message: 'The item must have a starting price'}
    validates_numericality_of :price 
    validates_uniqueness_of :title
    validates :when_date, presence: {message: 'End date and time cannot be blank'}

    has_many :bids
    has_many :users, through: :bids



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

    def check_status
        if self.status == 'pending' && self.when_date < DateTime.now
            # More than 0 bids and the auction has ended
            self.status = 'complete'
            self.save
        elsif self.status == 'open' && self.when_date < DateTime.now  
            # 0 bids and the auction has ended
            self.status = 'incomplete'
            self.save
        end
    end

    def is_auction_complete
        return self.status == 'complete'
    end
end
