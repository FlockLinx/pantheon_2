class PostPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    update?
  end

  def create?
    update?
  end

  def update?
    @user.organization.id == @record.organization_id && @user.employment.active_job?
  end
end
