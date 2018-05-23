class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  has_one :employment
  has_one :organization, through: :employment
  enum role: { dummy: 0, org_admin: 1 }

  include DeviseTokenAuth::Concerns::User


  def search_by_name name
    organization.users.where('name ILIKE ?', "%#{name}%")
  end
end
