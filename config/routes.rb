# encoding: utf-8
# frozen_string_literal: true

Rails.application.routes.draw do
  namespace(:agents) do
    root(to: 'dashboard#index')

    resources(:public_services)

    resources(:service_offerings) do
      resource(:target_public, module: :service_offerings)
    end

    resources(:measures)
  end

  concern(:actionable) do |options|
    resources(:steps, options.merge(only: %i(show update)))
    resources(:service_offerings, options.merge(only: :show)) do
      resources(:contacts, options.merge(only: %i(create), module: :service_offerings))
    end
  end

  resources(:housings, only: %i(show create)) do
    concerns(:actionable, module: :housings)
  end

  resources(:workings, only: %i(show create)) do
    concerns(:actionable, module: :workings)
  end

  mount(Flip::Engine => '/flip')
  mount(Nkss::Engine => '/styleguide')

  root to: 'visitors#index'

end
