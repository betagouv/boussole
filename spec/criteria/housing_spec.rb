# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Housing matching criteria', type: :criteria do
  RHIZOMES.each do |rhizome|
    it_should_behave_like(
      :criteria,
      Housing,
      YAML.load(File.read(Rails.root.join("config/criteria/#{rhizome}/housing.service_offerings.yml")))
    )
  end
end
