class V1::AcquireRewardsController < ApplicationController
  resource_description do
  # param_group :global_controllers,  DocumentationHelper
  short 'Adquire uma recompensa - Cria'
  end

  before_action :authenticate_user!

  api :POST, '/acquire_rewards', 'Adquire uma recompensa'
  def create
    @acquire = AcquireReward.new acquire_reward_params.merge!(user_id: current_user.id)

    if @acquire.buying_reward && @acquire.save
      render json: @acquire, status: 201
    else
      @acquire.errors.add(:base, "Nao possui estrelas suficientes") unless @acquire.buying_reward
      render json: @acquire.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def acquire_reward_params
    params.require(:acquire_reward).permit(
      :reward_id
    )
  end
end
