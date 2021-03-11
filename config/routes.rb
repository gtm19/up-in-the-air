Rails.application.routes.draw do
  require "sidekiq/web"
  devise_for :users
  root to: 'pages#home'

  resources :cities, only: [ :index, :show ]
  resources :potential_destinations, only: [ :index, :new, :create ]
  resources :trips do
   resources :trip_participants do
    resources :participant_scores, only: [:index, :update]
   end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
