class EmploymentSerializer < ActiveModel::Serializer
  attributes :name, :email, :created_at, :active

  def created_at
    object.created_at.strftime('%d/%m/%Y')
  end

  def active
    object.employment.active_job
  end
end
