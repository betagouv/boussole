Rails.application.routes.draw do
  resources(:projects, only: :new)

  root(to: 'visitors#index')
end
