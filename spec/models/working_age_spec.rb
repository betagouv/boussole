# encoding: utf-8
# frozen_string_literal: true

RSpec.describe WorkingAge, type: :model do
  it { is_expected.to belong_to(:target_public) }
  it { is_expected.to validate_presence_of(:target_public) }

  it 'validates that the #minimum is at least 16 and no more than 30' do
    is_expected.to(
      validate_numericality_of(:minimum)
        .is_greater_than_or_equal_to(16)
        .is_less_than_or_equal_to(30)
        .only_integer
        .allow_nil
    )
  end

  it 'validates that the #maximum is at least 16 and no more than 30' do
    is_expected.to(
      validate_numericality_of(:maximum)
        .is_greater_than_or_equal_to(16)
        .is_less_than_or_equal_to(30)
        .only_integer
        .allow_nil
    )
  end

  context "when #maximum is set and #minimum isn't" do
    subject(:working_age) { build(:working_age, maximum: 20) }

    it { is_expected.to validate_numericality_of(:minimum).is_less_than_or_equal_to(20) }
    it { is_expected.to validate_numericality_of(:maximum).is_less_than_or_equal_to(30) }
  end

  context "when #minimum is set and #maximum isn't" do
    subject(:working_age) { build(:working_age, minimum: 20) }

    it { is_expected.to validate_numericality_of(:maximum).is_greater_than_or_equal_to(20) }
    it { is_expected.to validate_numericality_of(:minimum).is_greater_than_or_equal_to(16) }
  end

  describe '#any?' do
    context 'when not persisted and #menimum and maximum are not set' do
      subject { build(:working_age).any? }

      it { is_expected.to be_falsey }
    end

    context "when persisted and #menimum and #maximum aren't set" do
      subject { create(:working_age).any? }

      it { is_expected.to be_falsey }
    end

    context 'when persisted and either #menimum or #maximum be set' do
      subject(:working_age) { create(:working_age, maximum: 20).any? }

      it { is_expected.to be_truthy }
    end
  end
end
