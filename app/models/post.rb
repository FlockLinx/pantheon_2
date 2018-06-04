class Post < ApplicationRecord
  validates :organization, :donator_id,
            :beneficiary_id, :cause,
            :star_amount, presence: true

  validate :same_organization
  validate :must_be_different

  belongs_to :donator, :class_name => "User", :foreign_key => "donator_id"
  belongs_to :beneficiary, :class_name => "User", :foreign_key => "beneficiary_id"
  belongs_to :organization

  scope :list, -> (user)  { where(organization_id: user.organization.id)}

  def star_exchanges
    donator_starbag = StarBag.find_by(user_id: donator_id)
    donator_starbag.available_stars -= star_amount.to_i
    donator_starbag.update(user_id: donator_id,
                           available_stars: donator_starbag.available_stars
                          )
  end

  def beneficiary_star
    beneficiary_starbag = StarBag.find_by(user_id: beneficiary_id)
    beneficiary_starbag.star_amount += star_amount.to_i
    beneficiary_starbag.update(user_id: beneficiary_id,
                               star_amount: beneficiary_starbag.star_amount
                              )
  end

  private

  def same_organization
    errors.add(:base, "precisa ser da mesma instituicao") unless beneficiary&.organization_id == donator&.organization_id
  end

  def must_be_different
    errors.add(:base, "nao pode ser a mesma pessoa") if beneficiary == donator
  end
end
