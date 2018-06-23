class Contact < ApplicationRecord

  validates :email, :subject, :message, presence: true


  after_create_commit :contact_mail


  private

  def contact_mail
    ContactUsMailer.report(self).deliver_later
  end

end
