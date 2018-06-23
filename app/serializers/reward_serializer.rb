class RewardSerializer < ActiveModel::Serializer

  attributes :name, :cost, :description, :organization_id
end
