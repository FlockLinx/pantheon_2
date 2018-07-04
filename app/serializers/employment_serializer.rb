class EmploymentSerializer < ActiveModel::Serializer
  attributes :created_at

  def created_at
    object.created_at.strftime('%d/%m/%Y')
  end

  def active
    object.employment.active_job
  end
end
