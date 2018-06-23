class ResetWarningWorker
  include Sidekiq::Worker

  def perform()
    User.pluck(:email).each do |mail|
      UserMailer.reset_warning_email(mail).deliver_later
    end
  end
end
