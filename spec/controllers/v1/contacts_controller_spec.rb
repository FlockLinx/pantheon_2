require 'rails_helper'

RSpec.describe V1::ContactsController, type: :controller do

  describe 'POST create' do
    context 'Create contact us with valid attribute' do
      it 'should create new contact', :show_in_doc do
        params = {
        	contact: {
            name: Faker::StarWars.character,
            email: Faker::Internet.email,
            phone: Faker::PhoneNumber.cell_phone,
            subject: Faker::StarWars.quote,
            origin: Faker::StarWars.planet,
            message:Faker::StarWars.wookiee_sentence
        	}
        }
        expect{
          post :create, params: params
        }.to change(Contact, :count).by(1)
      end
    end

    context 'Create contact us with invalid attributes' do
      it 'should not create a new contact', :show_in_doc do
        params = {
          contact: {
            name: Faker::StarWars.character,

            phone: Faker::PhoneNumber.cell_phone,
            subject: Faker::StarWars.quote,
            origin: Faker::StarWars.planet
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Contact, :count)
      end
    end
  end
end
