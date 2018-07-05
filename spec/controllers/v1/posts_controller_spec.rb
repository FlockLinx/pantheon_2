require 'rails_helper'

RSpec.describe V1::PostsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }


  let!(:random_user) { create(:user) }

  let!(:random_organization) { create(:organization) }
  let!(:random_employment) { create(:employment, user: random_user,
                                    organization: random_organization) }

  let!(:employment) { create(:employment, user: user,
                              organization: organization) }

  let!(:employment2) { create(:employment, user: user2,
                              organization: organization) }

  let!(:star_bag) { create(:star_bag, user: user,
                           organization: user.organization) }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end


  describe 'POST create' do
    context 'Create a new post with valid attribute' do
      it 'should create a post', :show_in_doc do
        params = {
        	post: {
             beneficiary_id: organization.owner.id,
             cause: Faker::StarWars.quote,
             amount: 10,
             tags: ['Learning', 'Excellence']
        	}
        }
        expect{
          post :create, params: params
        }.to change(Post, :count).by(1)
      end
    end

    context 'Create post with insuficient stars' do
      it 'should not create a new post', :show_in_doc do
        params = {
          post: {
             beneficiary_id: organization.owner.id,
             cause: Faker::StarWars.quote,
             amount: 30
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Post, :count)
        expect(response).to have_http_status(422)
      end

      it 'should not create a new post if beneficiary is equal to donator', :show_in_doc do
        params = {
          post: {
             beneficiary_id: user.id,
             cause: Faker::StarWars.quote,
             amount: 30
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Post, :count)
        expect(response).to have_http_status(422)
      end
    end

    context 'Create post with invalid user' do

      before do
        auth_headers = random_user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should not create a new post', :show_in_doc do
        params = {
          post: {
             beneficiary_id: organization.owner.id,
             cause: Faker::StarWars.quote,
             amount: 30
          }
        }
        expect{
          post :create, params: params
        }.not_to change(Post, :count)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET post show' do

    context 'post infos' do

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get post', :show_in_doc do
        post = Post.create(beneficiary_id: organization.owner.id,
                           donator_id: user.id,
                           amount: 2,
                           organization_id: organization.id,
                           cause: 'it is a test!' )

        get :show, params: { id: post.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'post infos from another organization' do

      before do
        auth_headers = random_user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get post', :show_in_doc do
        post = Post.create(beneficiary_id: organization.owner.id,
                           donator_id: user.id,
                           amount: 2,
                           organization_id: organization.id,
                           cause: 'it is a failing test!' )
        get :show, params: { id: Post.last.id }
        expect(response).to have_http_status(403)
      end
    end
  end


  describe 'GET posts feed' do

    context 'GET posts feed from organization' do

      before do
        auth_headers = user.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'should get post feed', :show_in_doc do
        3.times do
          Post.create(beneficiary_id: organization.owner.id,
                             donator_id: user.id,
                             amount: 2,
                             organization_id: organization.id,
                             cause: Faker::StarWars.quote,
                             tags: ['learning', 'Excellence'])
        end
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
