class Bid < ActiveRecord::Base
    delegate :email, to: :user, prefix: true
    belongs_to :post
    belongs_to :user
    validates_presence_of :amount
    validates_numericality_of :amount 
    validates_presence_of :user_id
    validates_presence_of :post_id
    
    def self.most_recent
        order("created_at").last
    end
    
end
