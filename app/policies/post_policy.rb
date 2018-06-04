class PostPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    update?
  end

  def show?
    update?
  end

  def create?
    update?
  end

  def update?
    @user.organization.id == @record.organization_id
  end
end
