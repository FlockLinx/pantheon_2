class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  has_one :employment
  has_one :star_bag
  has_one :organization, through: :employment
  has_many :phones, dependent: :destroy, as: :phoneable, inverse_of: :phoneable
  enum role: { dummy: 0, org_admin: 1 }
  accepts_nested_attributes_for :phones, allow_destroy: true


  include DeviseTokenAuth::Concerns::User


  def search_by_name name
    organization.users.where('name ILIKE ?', "%#{name}%")
  end
end
