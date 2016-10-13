class Bid < ActiveRecord::Base
  delegate :email, to: :user, prefix: true
  delegate :name, to: :user, prefix: true
  belongs_to :post
  belongs_to :user
  validates_presence_of :amount
  validates_numericality_of :amount
  validates_presence_of :user_id
  validates_presence_of :post_id
  
  validate :bid_amount_value

  after_save :update_item
  after_destroy :update_item

  def self.most_recent
    order(:created_at).last
  end

  def update_item
      self.post.check_highest_bid
  end

  def bid_amount_value
      errors.add(:amount, "Must be higher than current bid") unless self.post.price < self.amount
  end

end
