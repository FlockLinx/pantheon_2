class Employment < ApplicationRecord
  validates :organization_id, :user_id, presence: true

  def disable
    disabled = true
  end

  def disable!
    disable
    save
  end

  private
end
