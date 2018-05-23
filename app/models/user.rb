class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  has_one :employment
  has_one :organization, through: :employment
  include DeviseTokenAuth::Concerns::User


  def search_by_name name
    organization.users.where('name ILIKE ?', "%#{name}%")
  end
end
