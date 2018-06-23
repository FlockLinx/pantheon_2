class OrganizationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def employees_list?
    update?
  end

  def show?
    update?
  end

  def create?
    @user
  end

  def update?
    @user.org_admin? && @user.organization == @record
  end
end
