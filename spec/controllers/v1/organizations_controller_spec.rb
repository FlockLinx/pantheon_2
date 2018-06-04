require 'rails_helper'

RSpec.describe V1::OrganizationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:random_user) { create(:user) }
  let!(:organization) { create(:organization) }
  let!(:employment) { create(:employment, organization: organization,
                              user: user)
                    }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'POST create' do
    context 'Create organization valid attributes' do
      it 'should create new organization', :show_in_doc do
        params = {
        	organization: {
            trading_name: Faker::Company.name,
            stars_by_month: 20
          }
        }
        expect{
          post :create, params: params
        }.to change(Organization, :count).by(1)
      end
    end

    context 'Create organization with invalid attribute' do
      it 'should not create a new organization', :show_in_doc do

        params = {
          organization: {
            trading_name: Faker::Company.name
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Organization, :count)
      end
    end
  end

  describe 'PUT organization' do
    context 'Update organization' do

      before do
        auth_headers = organization.owner.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should update a organization', :show_in_doc do
        put :update, params: { id: organization.id, organization: { trading_name: 'My Company' } }
        organization.reload

        expect(organization.trading_name).to eq('My Company')
      end
    end

    context 'Update organization with random user' do

      before do
        auth_headers = random_user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should not update a organization', :show_in_doc do
        put :update, params: { id: organization.id, trading_name: 'My Company' }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'GET organization show' do

    context 'organization infos' do

      before do
        auth_headers = organization.owner.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get organization infos', :show_in_doc do
        get :show, params: { id: organization.id }
        expect(response).to have_http_status(200)
      end
    end


    context 'organization infos for random user' do

      before do
        auth_headers = random_user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should not get organization infos', :show_in_doc do

        get :show, params: { id: organization.id }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'GET employees list' do

    context 'Get organization employees list as owner' do

      before do
        auth_headers = organization.owner.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get employees list', :show_in_doc do

        get :employees_list
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'Get organization employees list as owner' do

    before do
      auth_headers = user.create_new_auth_token
      request.headers.merge!(auth_headers)
    end

    it 'should not get employees list', :show_in_doc do

      get :employees_list
      expect(response).to have_http_status(403)
    end
  end
end
