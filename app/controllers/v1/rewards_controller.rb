class V1::RewardsController < ApplicationController
  resource_description do
    # param_group :global_controllers,  DocumentationHelper
    short 'Reward'
  end

  before_action :set_reward, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  api :GET, '/rewards', 'Mostra as recompensas da empresa'
  def index
    @rewards = Reward.from_organization(current_user).page params[:page]
    render json: @rewards, each_serializer: RewardSerializer
  end

  def my_rewards
    @acquired_rewards = current_user.acquire_rewards
    render json: @acquired_rewards, each_serializer: AcquireRewardSerializer
  end

  api :GET, '/reward/:id', 'Mostra a recompensa individualmente'
  def show
    authorize @reward

    render json: @reward
  end

  api :PUT, '/reward/:id', 'Atualiza uma recompensa'
  def update
    authorize @reward

    if @reward.update reward_params
      render json: @reward
    else
      render json: @reward.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :POST, '/reward', 'Cria uma nova recompensa'
  def create
    @reward = Reward.new reward_params

    authorize @reward

    if @reward.save
      render json: @reward
    else
      render json: @reward.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/reward/:id', 'Remove uma recompensa'
  def destroy
    @reward.destroy
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_raw_params
    params.require(:reward).permit(
      :name,
      :cost,
      :quantity_total,
      :quantity_available,
      :description
    )
  end

  def reward_params
    reward_raw_params.merge!(organization_id: current_user.organization.id,
                             created_by_user_id: current_user.id)
   end
end
