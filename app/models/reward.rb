class Reward < ApplicationRecord
  validates :organization_id, :cost, :name, presence: true

  scope :from_organization, -> (user)  { where(organization_id: user.organization.id)}

end
