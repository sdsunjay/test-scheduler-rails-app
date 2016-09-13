class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :bids
  has_many :posts, through: :bids, dependent: :destroy
end
