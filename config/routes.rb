Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  get 'posts'   => 'posts#index'

  get 'kittens' => 'async#index'
  get 'kitten'  => 'async#kitten'

  resources :widgets

end
