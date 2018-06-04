class OrganizationSerializer < ActiveModel::Serializer
  attributes :trading_name, :stars_by_month
  has_many :phones
  has_one :address
end
