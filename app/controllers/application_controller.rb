class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized exception
    policy_name = exception.policy.class.to_s.underscore
    render json: { message: I18n.t("pundit.#{policy_name}.#{exception.query}") }, status: :forbidden
  end
end
