Rails.application.routes.draw do
  resources :deals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # # Standalone routes for leads
  # resources :leads

  # Standalone routes for deals
  resources :deals

  # Nested route for deals within leads, only for index action
  resources :leads do
    resources :deals, only: [:index]
  end
end
