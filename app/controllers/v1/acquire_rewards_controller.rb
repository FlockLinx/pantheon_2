class V1::AcquireRewardsController < ApplicationController

  before_action :authenticate_user!

  def create
    @acquire = AcquireReward.new acquire_reward_params.merge!(user_id: current_user.id)

    if @acquire.save && @acquire.buying_reward
      render json: @acquire, status: 201
    else
      @acquire.errors.add(:base, "lalalalala") unless @acquire.buying_reward
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
