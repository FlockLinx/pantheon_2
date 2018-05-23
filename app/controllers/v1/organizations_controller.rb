class V1::OrganizationsController < ApplicationController
  # resource_description do
  #   param_group :global_controllers,  DocumentationHelper
  #   short 'Organization'
  # end

  before_action :set_organization, only: [:show, :update]
  before_action :authenticate_user!

  # api :GET, '/organization/:id', 'Mostra instituicao organization'
  def show
    authorize @organization

    render json: @organization
  end

  # api :PUT, '/organization/:id', 'Atualiza uma organization'
  def update
    authorize @organization

    if @organization.save
      render json: @organization
    else
      render json: @organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  # api :POST, '/organizations', 'Cria uma nova empresa'
  def create
    @organization = Organization.new organization_params

    authorize @organization

    if @organization.save
      render json: @organization
    else
      render json: @organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_raw_params
    params.require(:organization).permit(
      :trading_name,
      organization_tags: []
    )
  end

  def organization_params
    organization_raw_params.merge!(owner_id: current_user.id,
                                   created_by_user_id: current_user.id
                                  )
  end
end
