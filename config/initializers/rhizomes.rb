# encoding: utf-8
# frozen_string_literal: true

module Boussole
  # :nodoc:
  class Application < Rails::Application
    config.rhizome = ENV['RHIZOME'] || RHIZOMES.first
  end
end
