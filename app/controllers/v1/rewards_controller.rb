class V1::RewardsController < ApplicationController
  # resource_description do
  #   param_group :global_controllers,  DocumentationHelper
  #   short 'Reward'
  # end

  before_action :set_reward, only: [:show, :update]
  # before_action :authenticate_user!

  # api :GET, '/reward', 'Mostra instituicoes'
  def index
    @reward = Reward.all
    render json: @reward
  end

  # api :GET, '/reward/:id', 'Mostra instituicao individualmente'
  def show
    authorize @reward

    render json: @reward
  end

  # api :PUT, '/reward/:id', 'Atualiza uma instituicao de saude'
  def update
    authorize @reward

    if @reward.save
      render json: @reward
    else
      render json: @reward.errors.full_messages, status: :unprocessable_entity
    end
  end

  # api :POST, '/reward', 'Cria uma nova instituicao de saude com seu CNPJ
  def create
    @reward = Reward.new reward_params

    authorize @reward

    if @reward.save
      render json: @reward
    else
      render json: @reward.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(
      :name,
      :cost,
      :displaed_cost,
      :ordanization_id
    )
  end
end
