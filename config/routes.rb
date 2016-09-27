# encoding: utf-8
# frozen_string_literal: true

Rails.application.routes.draw do
  namespace(:agents) do
    root(to: 'dashboard#index')

    resources(:public_services)
    resources(:service_offerings)
    resources(:measures)
  end

  # TODO: Rename to trainings
  resources(:projects, only: %i(show create)) do
    resources(:steps, only: %i(show update), module: :projects)
  end

  # TODO: Create a concern to DRY
  resources(:housings, only: %i(show create)) do
    resources(:steps, only: %i(show update), module: :housings)
    resources(:service_offerings, only: :show, module: :housings)
  end

  # TODO: Create a concern to DRY
  resources(:workings, only: %i(show create)) do
    resources(:steps, only: %i(show update), module: :workings)
    resources(:service_offerings, only: :show, module: :workings)
  end

  resources(:contacts, only: %i(show create))

  mount(Flip::Engine => '/flip')

  get '/:flyer', to: 'visitors#index', constraints: { flyer: /reims1[A|B|C|D|E|F|G|H|J|K|L|N]/ }

  root to: 'visitors#index'
end
