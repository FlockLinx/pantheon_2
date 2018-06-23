require 'rails_helper'

RSpec.describe V1::AcquireRewardsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:reward) { create(:reward, organization_id: organization.id) }

  before do
    auth_headers = organization.owner.create_new_auth_token
    request.headers.merge!(auth_headers)
  end


  describe 'POST create' do
    context 'Acquire reward with valid attribute' do
      it 'should acquire a reward', :show_in_doc do
        organization.owner.star_bag.star_amount = 10
        organization.owner.star_bag.save!

        params = {
        	acquire_reward: {
            reward_id: reward.id
        	}
        }
        expect{
          post :create, params: params
        }.to change(AcquireReward, :count).by(1)
      end
    end

    context 'Acquire reward with insuficient stars' do
      it 'should not create a new contact', :show_in_doc do

        params = {
            acquire_reward: {
              reward_id: reward.id
            }
        }
        expect{
          post :create, params: params
        }.not_to change(AcquireReward, :count)
        expect(response).to have_http_status(422)
      end
    end
  end
end
