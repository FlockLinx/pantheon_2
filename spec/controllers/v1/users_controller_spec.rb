require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do

  describe 'POST create' do
    context 'Create user with valid attribute' do
      it 'should create new contact', :show_in_doc do
        params = {
        	user: {
            name: Faker::StarWars.character,
            email: Faker::Internet.email,
            password: "Wannacry",
            password_confirmation:  "Wannacry"
        	}
        }
        expect{
          post :create, params: params
        }.to change(User, :count).by(1)
      end
    end

    context 'Create user with invalid attribute' do
      it 'should create new contact', :show_in_doc do
        params = {
          user: {
            name: Faker::StarWars.character,
            password: "Wannacry",
            password_confirmation:  "Wannacry"
          }
        }
        expect{
          post :create, params: params
        }.not_to change(User, :count)
      end
    end
  end
end
