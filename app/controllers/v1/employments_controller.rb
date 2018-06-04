class V1::EmploymentsController < ApplicationController
  resource_description do
  # param_group :global_controllers,  DocumentationHelper
  short 'Vinculo Empregaticio - Cria, Remove'
  end

  before_action :authenticate_user!

  api :POST, '/employments', 'Cria um vinculo Empregaticio'
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
