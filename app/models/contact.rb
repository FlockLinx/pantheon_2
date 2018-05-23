class Contact < ApplicationRecord

  validates :email, :subject, :message, presence: true

end
