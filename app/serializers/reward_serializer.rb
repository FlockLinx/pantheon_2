class RewardSerializer < ActiveModel::Serializer

  attributes :id, :name, :cost, :description, :organization_id
end
