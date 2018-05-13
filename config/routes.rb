Rails.application.routes.draw do

  root to: 'users#new'
  get 'sessions/new', to: 'users#new'
  get 'users/new', to: 'users#new'

  resources :pictures do
    collection do
      post :confirm
    end
  end

  resources :users, only: %i[new create show]

  resources :sessions, only: %i[new create destroy]

  resources :favorites, only: %i[create destroy]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
