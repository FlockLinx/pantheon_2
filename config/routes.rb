Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :v1 do

    resources :users
    resources :posts
    resources :rewards
    resources :organizations
    resources :employments
    resources :contacts
  end

end
