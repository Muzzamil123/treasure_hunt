require 'sidekiq/web'

Rails.application.routes.draw do
  # for checking sidekiq jobs
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      post 'treasure_hunt', to: 'analytics#create', as: :treasure_hunt
      get 'analytics', to: 'analytics#stats', as: :treasure_stats
    end
  end
end
