# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :having_many_through do |association_name|
  subject(:record) { build(described_class.name.underscore) }
  let(:through) { "#{association_name.to_s.singularize}_#{described_class.name.underscore.pluralize}" }

  it { expect(record).to have_many(through) }
  it { expect(record).to have_many(association_name).through(through) }
end
