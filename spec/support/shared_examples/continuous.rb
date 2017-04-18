# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :continuous do
  context "when #maximum is set and #minimum isn't" do
    subject { build(described_class.name.underscore, maximum: 20) }

    it { is_expected.to validate_numericality_of(:minimum).is_less_than_or_equal_to(20) }
  end

  context "when #minimum is set and #maximum isn't" do
    subject { build(described_class.name.underscore, minimum: 20) }

    it { is_expected.to validate_numericality_of(:maximum).is_greater_than_or_equal_to(20) }
  end
end
