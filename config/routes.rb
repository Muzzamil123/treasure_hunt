Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      post 'treasure_hunt', to: 'analytics#create', as: :treasure_hunt
      get 'analytics', to: 'analytics#analytics', as: :analytics
    end
  end
end
