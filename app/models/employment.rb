class Employment < ApplicationRecord
  belongs_to :userable, polymorphic: true
  belongs_to :placeable, polymorphic: true

  validates_uniqueness_of :userable_id, scope: [:placeable_id, :placeable_type]

  validates :placeable, :userable, presence: true

  def disable
    disabled = true
  end

  def disable!
    disable
    save
  end

  private
end
