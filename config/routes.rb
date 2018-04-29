Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'

  resources :users
  resources :posts
  resources :rewards
  resources :organizations
end
