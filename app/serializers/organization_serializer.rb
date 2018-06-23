class OrganizationSerializer < ActiveModel::Serializer
  attributes :trading_name, :stars_by_month, :organization_tags
  has_many :phones
  has_one :address
end
