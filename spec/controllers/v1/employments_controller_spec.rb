require 'rails_helper'

RSpec.describe V1::EmploymentsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user) }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end


  describe 'POST create' do
    context 'Create employment with valid attributes' do
      it 'should acquire an employment', :show_in_doc do
        params = {
        	employment: {
            user_id: user.id,
            organization_id: organization.id
        	}
        }
        expect{
          post :create, params: params
        }.to change(Employment, :count).by(1)
      end
    end

    context 'Create employment with invalid attributes' do
      it 'should not create a new employment', :show_in_doc do

        params = {
          employment: {
            organization_id: organization.id
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Employment, :count)
        expect(response).to have_http_status(422)
      end
    end
  end
end
