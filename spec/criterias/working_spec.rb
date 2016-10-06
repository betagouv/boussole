# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Working matching criterias', type: :criteria do
  it_should_behave_like(
    'criterias',
    Working,
    YAML.load(File.read(Rails.root.join('config/criterias/reims/working.service_offerings.yml')))
  )
end
