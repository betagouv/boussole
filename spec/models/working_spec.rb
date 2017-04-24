# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Working, type: :model do
  context 'validations' do
    context 'awareness' do
      subject { build(:working, :awareness) }

      it { is_expected.to validate_presence_of(:awareness) }
      it { is_expected.to validate_inclusion_of(:awareness).in_array(AWARENESSES) }
    end

    context 'project' do
      subject { build(:working, :project) }

      it { is_expected.not_to validate_presence_of(:sector) }
      it { is_expected.to validate_inclusion_of(:sector).in_array(SECTORS) }

      it { is_expected.to validate_presence_of(:duration) }
      it { is_expected.to validate_inclusion_of(:duration).in_array(WORKING_DURATIONS) }

      it { is_expected.to validate_presence_of(:engagement) }
      it { is_expected.to validate_inclusion_of(:engagement).in_array(ENGAGEMENTS) }
    end

    context 'situation' do
      subject { build(:working, :situation) }

      it { is_expected.to validate_presence_of(:status) }
      it { is_expected.to validate_inclusion_of(:status).in_array(STATUSES) }

      it { is_expected.to validate_presence_of(:last_class) }
      it { is_expected.to validate_inclusion_of(:last_class).in_array(LAST_CLASSES) }

      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_inclusion_of(:city).in_array(CITIES[Rails.application.config.rhizome]) }

      it { is_expected.to validate_presence_of(:age) }
    end
  end
end
