class AcquireRewardSerializer < ActiveModel::Serializer
  attributes :acquired_rewards

  def acquired_rewards
    {
      acquired_at: object.created_at.strftime('%d/%m/%Y'),
      name: object.reward.name,
      cost: object.reward.cost,
      description: object.reward.description
    }
  end
end
