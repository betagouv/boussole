# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Working matching criteria', type: :criteria do
  RHIZOMES.each do |rhizome|
    it_should_behave_like(
      :criteria,
      Working,
      YAML.safe_load(File.read(Rails.root.join("config/criteria/#{rhizome}/working.service_offerings.yml")))
    )
  end
end
