# encoding: utf-8
# frozen_string_literal: true

Rails.application.routes.draw do
  resources :projects, only: %i(show create) do
    resources :steps, only: %i(show update), module: :projects
  end

  resources :housings, only: %i(show create) do
    resources :steps, only: %i(show update), module: :housings
  end

  resources :contacts, only: %i(show create)

  mount Flip::Engine => '/flip'

  root to: 'visitors#index'
end
