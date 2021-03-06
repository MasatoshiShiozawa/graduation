Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :specials do
    collection do
      post :confirm
      patch :confirm
    end
    member do
      patch :confirm
    end
    resources :comments
  end

  resources :favorites, only: [:create, :destroy]
  resources :special_category_relations, only: [:new]
  root 'specials#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
