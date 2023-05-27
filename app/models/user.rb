class User < ApplicationRecord
  # User Inform
  has_secure_password validations: true
  has_many :tokens
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_one_attached :avatar, optional: true, allow_blank: true
  validates :email, uniqueness: true
  validates :street, :city, :state, :postal_code, :country, presence: true

  # tweets, likes, retweets, followers, following
  has_many :tweets, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :liked_by, through: :likes, source: :user

  has_many :retweets, dependent: :destroy
  has_many :retweeted_tweets, through: :retweets, source: :tweet
  has_many :retweeted_by, through: :retweets, source: :user

  has_many :follows_as_follower,
           class_name: "Follow",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :followings, through: :follows_as_follower, source: :following
  has_many :follows_as_following,
           class_name: "Follow",
           foreign_key: "following_id",
           dependent: :destroy
  has_many :followers, through: :follows_as_following, source: :follower
end
