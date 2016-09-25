# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housing, type: :model do
  context 'validations' do
    context 'housing' do
      subject { build(:housing, :housing) }

      it { is_expected.to validate_presence_of(:duration) }
      it { is_expected.to validate_inclusion_of(:duration).in_array(DURATIONS) }

      it { is_expected.to validate_presence_of(:housing_city) }
    end

    context 'profile' do
      subject { build(:housing, :profile) }

      it { is_expected.to validate_presence_of(:current_status) }
      it { is_expected.to validate_inclusion_of(:current_status).in_array(STATUSES) }

      it { is_expected.to validate_presence_of(:age) }
    end
  end
end
