# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :targetable do |criterium|
  subject(:record) { build(described_class.name.underscore) }

  it { expect(record).to validate_presence_of(:target_public) }
  it { expect(record).to validate_presence_of(criterium) }
end
