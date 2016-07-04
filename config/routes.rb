Rails.application.routes.draw do
  resources :projects, only: %i(show create) do
    resources :steps, only: %i(show update), module: :projects
  end

  resources :housings, only: %i(show create) do
    resources :steps, only: %i(show update), module: :housings
  end

  root to: 'visitors#index'
end
