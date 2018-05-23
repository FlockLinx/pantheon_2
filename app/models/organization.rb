class Organization < ApplicationRecord

  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

  has_many :rewards
  has_many :employments
  has_many :users, through: :employments

  validates :owner_id, :created_by_user_id, :trading_name, presence: true

  after_create :update_owner_user_role
  
  private

  def update_owner_user_role
    usr = User.find self.owner_id
    usr.update(role: 1)
  end

end
