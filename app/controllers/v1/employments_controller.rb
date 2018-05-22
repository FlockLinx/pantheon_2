class V1::EmploymentsController < ApplicationController

  # before_action :authenticate_user!
  # before_action :set_relation, only: [:create, :destroy]

  def create
    @job = Employment.new job_params

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

  def job_params
    params.require(:job).permit(
      :user_id,
      :organization_id
    )
  end
end
