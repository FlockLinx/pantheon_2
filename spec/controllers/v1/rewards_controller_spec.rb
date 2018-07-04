require 'rails_helper'

RSpec.describe V1::RewardsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:random_user) { create(:user) }
  let!(:organization) { create(:organization) }
  let!(:employment) { create(:employment, organization: organization,
                              user: user)
                    }
  let!(:reward) { create(:reward, organization: organization) }

  before do
    auth_headers = organization.owner.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'POST create' do
    context 'Create reward valid attributes' do
      it 'should create new reward', :show_in_doc do
        params = {
        	reward: {
            name: Faker::Beer.name,
            cost: Faker::Number.number(2),
            quantity_total: Faker::Number.number(2),
            quantity_available: Faker::Number.number(2),
            description: Faker::LeagueOfLegends.quote
          }
        }
        expect{
          post :create, params: params
        }.to change(Reward, :count).by(1)
      end
    end

    context 'Create reward with invalid attribute' do
      it 'should not create a new reward', :show_in_doc do

        params = {
          reward: {
            trading_name: Faker::Company.name
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Reward, :count)
      end
    end
  end

  describe 'PUT reward' do
    context 'Update reward' do

      before do
        auth_headers = organization.owner.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should update a reward', :show_in_doc do
        put :update, params: { id: reward.id, reward: { name: 'My reward' } }
        reward.reload
        expect(reward.name).to eq('My reward')
      end
    end

    context 'Update reward with random user' do

      before do
        auth_headers = random_user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should not update a reward', :show_in_doc do
        put :update, params: { id: reward.id, name: 'My reward' }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'GET reward show' do

    context 'reward infos' do

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get reward infos', :show_in_doc do
        get :show, params: { id: reward.id }
        expect(response).to have_http_status(200)
      end
    end


    context 'reward infos for random user' do

      before do
        auth_headers = random_user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should not get reward infos', :show_in_doc do

        get :show, params: { id: reward.id }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'GET reward list' do

    context 'Get reward list' do

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get reward list', :show_in_doc do

        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET acquired rewards list' do

    context 'Get acquired reward list' do

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get acquired reward list', :show_in_doc do

        get :my_rewards
        expect(response).to have_http_status(200)
      end
    end
  end
end
