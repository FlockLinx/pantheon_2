class AcquireReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  validates :user, :reward, presence: true
  validate :same_organization
  validate :active_reward

  def buying_reward
    cost = reward.cost
    bag = user.star_bag.star_amount
    if cost <= bag
      user.star_bag.star_amount = user.star_bag.star_amount - cost
      return true if user.star_bag.save!
    end
    false
  end

  private

  def same_organization
    errors.add(:base, "Precisa ser da mesma instituicao") unless reward.organization_id == user.organization.id
  end

  def active_reward
    errors.add(:base, "Deve estar ativa") unless reward.active
  end
end
