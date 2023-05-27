class Role < ApplicationRecord
  validates_uniqueness_of :slug, presence: true
end
