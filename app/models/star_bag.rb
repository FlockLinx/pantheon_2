class StarBag < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates :available_stars,
            :star_amount, :numericality => { :greater_than_or_equal_to => 0 }
end
