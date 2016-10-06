# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Housing matching criterias', type: :criteria do
  it_should_behave_like(
    'criterias',
    Housing,
    YAML.load(File.read(Rails.root.join('config/criterias/reims/housing.service_offerings.yml')))
  )
end
