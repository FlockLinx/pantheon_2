class PostSerializer < ActiveModel::Serializer

  attributes :id, :donator, :beneficiary, :star_amount, :cause

  def donator
    object.donator.name
  end

  def beneficiary
    object.beneficiary.name
  end
end
