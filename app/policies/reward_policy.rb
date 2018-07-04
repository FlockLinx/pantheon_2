class RewardPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    @user.organization == record.organization
  end

  def create?
    @user.org_admin?
  end

  def update?
    @user.org_admin? && @user.organization == @record.organization
  end

  def create?
    true
  end
end
