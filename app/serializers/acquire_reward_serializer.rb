class AcquireRewardSerializer < ActiveModel::Serializer
  attributes :name, :cost, :description, :acquired_at

  def acquired_at
    object.created_at.strftime('%d/%m/%Y')
  end

  def name
    object.reward.name
  end

  def cost
    object.reward.cost
  end

  def description
    object.reward.description
  end
end
