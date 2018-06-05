class Organization < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :rewards
  has_many :employments
  has_many :star_bags
  has_many :users, through: :employments
  has_many :phones, dependent: :destroy, as: :phoneable, inverse_of: :phoneable
  has_one :address, dependent: :destroy, as: :addressable,
                                         inverse_of: :addressable

  validates :owner_id,
            :trading_name, :stars_by_month, presence: true

  after_create :update_owner_user_role

  accepts_nested_attributes_for :phones, :address, allow_destroy: true
  after_save :reload

  def employees
    employments.map(&:user)
  end

  private

  def update_owner_user_role
    usr = User.find owner_id
    usr.update(role: 1)

    Employment.create(user_id: usr.id, organization_id: id)
  end
end
