# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :read_only do |attribute|
  subject(:record) { create(described_class.name.underscore) }

  describe 'destroying a record' do
    it 'raises a ReadOnlyRecord error' do
      expect { record.destroy }.to raise_error(ActiveRecord::ReadOnlyRecord)
      expect { record.destroy! }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end
  end

  it { expect(described_class.readonly_attributes.to_a).to include(attribute.to_s) }
end
