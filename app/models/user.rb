class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :confirmable,
          :recoverable, :rememberable, :trackable, :validatable
  has_one :employment
  has_one :star_bag
  has_one :organization, through: :employment
  has_many :acquire_rewards
  has_many :phones, dependent: :destroy, as: :phoneable, inverse_of: :phoneable
  enum role: { dummy: 0, org_admin: 1 }
  accepts_nested_attributes_for :phones, allow_destroy: true

  after_create_commit :confirmation_instructions

  include DeviseTokenAuth::Concerns::User


  def search_by_name name
    organization.users.where('name ILIKE ?', "%#{name}%")
  end

  private

  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(self, self.confirmation_token).deliver_later
  end
end
