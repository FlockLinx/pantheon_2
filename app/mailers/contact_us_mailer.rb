class ContactUsMailer < ApplicationMailer
  def report(contact)
    @contact = contact
    recipient   = "bom.trabalho.suporte@gmail.com"
    subject     = "Novo contato"
    mail(to: recipient, subject: subject)
  end
end
