require 'rails_helper'

RSpec.describe V1::OrganizationsController, type: :controller do
  let!(:user) { create(:user) }

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
end
