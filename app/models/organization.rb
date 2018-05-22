class Organization < ApplicationRecord
  has_many :rewards
  has_many :employments
  has_many :users, through: :employments
end
