class RewardPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    @user.organization.id == record.organization_id
  end

  def create?
    true
  end

  def update?
    @user == @record
  end
end
