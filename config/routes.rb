Rails.application.routes.draw do
  resources :projects, only: %i(create) do
    resources :steps, only: %i(show update), module: :projects
  end

  root to: 'visitors#index'
end
