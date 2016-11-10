# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Working matching criterias', type: :criteria do
  # TODO: Move rhizome collection to config file
  %w(reims coeuressonne).each do |rhizome|
    it_should_behave_like(
      'criterias',
      Working,
      YAML.load(File.read(Rails.root.join("config/criterias/#{rhizome}/working.service_offerings.yml")))
    )
  end
end
