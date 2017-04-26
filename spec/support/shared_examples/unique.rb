# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :unique do |attribute, kind|
  subject(:record) { build(described_class.name.underscore) }

  it { expect(record).to validate_presence_of(attribute) } if kind == :string
  it { expect(record).to validate_inclusion_of(attribute).in_array([true, false]) } if kind == :boolean
  it { expect(record).to validate_uniqueness_of(attribute) }
end
