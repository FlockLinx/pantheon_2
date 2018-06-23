class UserSerializer < ActiveModel::Serializer
  has_one :star_bag
  has_one :organization
  attributes :id, :name, :email, :secondary_email
end
