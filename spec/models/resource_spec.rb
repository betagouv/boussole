# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Resource, type: :model do
  it_should_behave_like :belonging_to, :target_public
  it_should_behave_like :continuous

  it { is_expected.to validate_numericality_of(:minimum).only_integer.allow_nil }
  it { is_expected.to validate_numericality_of(:maximum).only_integer.allow_nil }
end
