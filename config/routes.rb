Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'widgets#index'

  resources :widgets
  get 'possibilities', to: 'widgets#all'

  get 'kittens' => 'async#index'
  get 'kitten'  => 'async#kitten'
end
