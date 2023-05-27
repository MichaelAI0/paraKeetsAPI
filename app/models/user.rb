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

  def name
    "#{first_name} #{last_name}"
  end
  # Methods to be called by tweets, retweets, follows, etc.. controllers

  def like(tweet)
    likes.create(tweet: tweet)
  end

  def unlike(tweet)
    likes.find_by(tweet: tweet).destroy
  end

  def retweet(tweet)
    retweets.create(tweet: tweet)
  end

  def unretweet(tweet)
    retweets.find_by(tweet: tweet).destroy
  end

  def follow(user)
    follows.create(following: user)
  end

  def unfollow(user)
    follows.find_by(following: user).destroy
  end

  def following?(user)
    followings.exists?(user.id)
  end
end
