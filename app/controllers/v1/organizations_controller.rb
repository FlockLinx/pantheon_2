class V1::OrganizationsController < ApplicationController
  resource_description do
    # param_group :global_controllers,  DocumentationHelper
    short 'Organization'
  end

  before_action :set_organization, only: [:show, :update]
  before_action :authenticate_user!

  api :GET, '/organizations/employees_list', 'Mostra os funcionarios cadastrados da organizacao do usuario logado'
  def employees_list
    @organization = current_user.organization

    authorize @organization

    render json: @organization.employees
  end


  api :GET, '/organization/:id', 'Mostra a organizacao do usuario logado'
  def show
    authorize @organization

    render json: @organization
  end

  api :PUT, '/organization/:id', 'Atualiza uma organization exclusivo para owner'
  def update
    authorize @organization

    if @organization.save
      render json: @organization
    else
      render json: @organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :POST, '/organizations', 'Cria uma nova organizacao'
  def create
    @organization = Organization.new organization_params

    # authorize @organization

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
      :stars_by_month,
      organization_tags: [],
      address_attributes: [
        :id,
        :uf,
        :street,
        :number,
        :zipcode,
        :complement,
        :city,
        :neighborhood,
        :_destroy
      ],
      phones_attributes: [
        :id,
        :number,
        :_destroy
      ]
    )
  end

  def organization_params
    organization_raw_params.merge!(owner_id: current_user.id,
                                   created_by_user_id: current_user.id
                                  )
  end
end
