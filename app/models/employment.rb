class Employment < ApplicationRecord
  validates :organization_id, :user_id, presence: true
  belongs_to :user
  belongs_to :organization

  after_create :set_star_amount

  private

  def set_star_amount
    StarBag.create(user_id: user_id,
                   organization_id: organization_id,
                   available_stars: organization.stars_by_month
                  )
  end

end
