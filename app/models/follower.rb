class Follower < ApplicationRecord
  belongs_to :follower
  belongs_to :following
end
