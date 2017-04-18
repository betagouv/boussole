# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :belonging_to do |association_name|
  subject { build(described_class.name.underscore) }

  it { is_expected.to belong_to(association_name) }
  it { is_expected.to validate_presence_of(association_name) }

  describe '#any?' do
    context 'when not persisted and #menimum and maximum are not set' do
      subject { build(described_class.name.underscore).any? }

      it { is_expected.to be_falsey }
    end

    context "when persisted and #menimum and #maximum aren't set" do
      subject { create(described_class.name.underscore).any? }

      it { is_expected.to be_falsey }
    end

    context 'when persisted and either #menimum or #maximum be set' do
      subject { create(described_class.name.underscore, maximum: 20).any? }

      it { is_expected.to be_truthy }
    end
  end
end
