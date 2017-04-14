# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :unique do
  subject(:record) { build(described_class.name.underscore) }

  it { expect(record).to validate_presence_of(:name) }
  it { expect(record).to validate_uniqueness_of(:name) }
end
