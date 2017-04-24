# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Housing matching criterias', type: :criteria do
  RHIZOMES.each do |rhizome|
    it_should_behave_like(
      'criterias',
      Housing,
      YAML.load(File.read(Rails.root.join("config/criterias/#{rhizome}/housing.service_offerings.yml")))
    )
  end
end
