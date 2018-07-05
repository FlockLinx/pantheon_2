class PostPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.organization.id == @record.pluck(:organization_id).first && @user.employment.active_job?
  end

  def show?
    update?
  end

  def create?
    @user.organization.id == @record.organization_id && @user.employment.active_job?
  end

  def update?
    @user.id == @record.donator_id && @user.employment.active_job? || @user.org_admin? && @record.organization_id == @user.organization.id
  end
end
