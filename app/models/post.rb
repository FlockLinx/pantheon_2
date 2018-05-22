class Post < ApplicationRecord

  validates :organization, :donator_id,
            :beneficiary_id, :cause,
            :star_amount, presence: true

  validate :same_organization
  validate :must_be_different
  # validate :available_stars

  belongs_to :donator, :class_name => "User", :foreign_key => "donator_id"
  belongs_to :beneficiary, :class_name => "User", :foreign_key => "beneficiary_id"
  belongs_to :organization

  private

  def same_organization
    errors.add(:base, "precisa ser da mesma instituicao") unless beneficiary.organization_id == donator.organization_id
  end

  def must_be_different
    errors.add(:base, "nao pode ser a mesma pessoa") if beneficiary == donator
  end

end
