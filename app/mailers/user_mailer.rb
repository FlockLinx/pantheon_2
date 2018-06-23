class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bem vinda(o) a Pantheon!')
  end


  def reset_warning_email(email)
    @email = email
    mail(to: @email, subject: 'Corra!! seu saldo de estrelas vai ser resetado!')
  end
end
