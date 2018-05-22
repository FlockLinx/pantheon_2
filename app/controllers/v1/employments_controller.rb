class V1::EmploymentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @job = Employment.new employment_params

    if @job.save
      render json: @job
    else
      render json: @job.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    #whait
  end

  private

  def employment_params
    params.require(:employment).permit(
      :user_id,
      :organization_id
    )
  end
end
