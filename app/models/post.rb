class Post < ApplicationRecord
  validates :organization, :donator_id,
            :beneficiary_id, :cause,
            :amount, presence: true

  validate :same_organization
  validate :must_be_different

  belongs_to :donator, class_name: 'User', foreign_key: 'donator_id'
  belongs_to :beneficiary, class_name: 'User', foreign_key: 'beneficiary_id'
  belongs_to :organization

  scope :list, -> (user)  { where(organization_id: user.organization.id, active: true)}

  def star_exchanges
    donator_starbag = StarBag.find_by(user_id: donator_id)
    donator_starbag.available_stars -= amount
    available_stars donator_starbag
    donator_starbag.update(available_stars: donator_starbag.available_stars)
  end

  def beneficiary_star
    beneficiary_starbag = StarBag.find_by(user_id: beneficiary_id)
    beneficiary_starbag.star_amount += amount
    beneficiary_starbag.save!
  end

  private

  def available_stars star_bag
    errors.add(:base, :available_stars) unless star_bag.available_stars >= 0
  end

  def same_organization
    errors.add(:base, :invalid) unless beneficiary&.organization.id == donator&.organization.id
  end

  def must_be_different
    errors.add(:base, :must_be_different) if beneficiary == donator
  end
end
