# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TargetPublic, type: :model do
  it { is_expected.to belong_to(:service_offering) }

  it { is_expected.to have_many(:target_public_apecs) }
  it { is_expected.to have_many(:apecs).through(:target_public_apecs) }

  it { is_expected.to have_many(:target_public_awarenesses) }
  it { is_expected.to have_many(:awarenesses).through(:target_public_awarenesses) }

  it { is_expected.to have_many(:target_public_cap_emplois) }
  it { is_expected.to have_many(:cap_emplois).through(:target_public_cap_emplois) }

  it { is_expected.to have_many(:target_public_engagements) }
  it { is_expected.to have_many(:engagements).through(:target_public_engagements) }

  it { is_expected.to have_many(:target_public_experiences) }
  it { is_expected.to have_many(:experiences).through(:target_public_experiences) }

  it { is_expected.to have_many(:target_public_handicaps) }
  it { is_expected.to have_many(:handicaps).through(:target_public_handicaps) }

  it { is_expected.to have_many(:target_public_housing_durations) }
  it { is_expected.to have_many(:housing_durations).through(:target_public_housing_durations) }

  it { is_expected.to have_many(:target_public_housing_statuses) }
  it { is_expected.to have_many(:housing_statuses).through(:target_public_housing_statuses) }

  it { is_expected.to have_many(:target_public_last_classes) }
  it { is_expected.to have_many(:last_classes).through(:target_public_last_classes) }

  it { is_expected.to have_many(:target_public_mission_locales) }
  it { is_expected.to have_many(:mission_locales).through(:target_public_mission_locales) }

  it { is_expected.to have_many(:target_public_pole_emplois) }
  it { is_expected.to have_many(:pole_emplois).through(:target_public_pole_emplois) }

  it { is_expected.to have_many(:target_public_working_durations) }
  it { is_expected.to have_many(:working_durations).through(:target_public_working_durations) }

  it { is_expected.to have_many(:target_public_working_statuses) }
  it { is_expected.to have_many(:working_statuses).through(:target_public_working_statuses) }

  it { is_expected.to have_one(:working_age) }
  it { is_expected.to accept_nested_attributes_for(:working_age) }

  it { is_expected.to have_one(:housing_age) }
  it { is_expected.to accept_nested_attributes_for(:housing_age) }

  it { is_expected.to have_one(:resource) }
  it { is_expected.to accept_nested_attributes_for(:resource) }

  describe '#criteria' do
    let(:service_offering) { create(:service_offering, social_right: social_right) }
    let(:target_public)    { service_offering.target_public }
    subject                { target_public.criteria }

    context 'when for working social right' do
      let(:social_right) { create(:social_right, :working) }

      it { is_expected.to include(:working_durations) }
      it { is_expected.to include(:working_age) }
      it { is_expected.to include(:working_statuses) }
      it { is_expected.to include(:engagements) }
      it { is_expected.to include(:awarenesses) }
      it { is_expected.to include(:last_classes) }
      it { is_expected.to include(:experiences) }
      it { is_expected.to include(:mission_locales) }
      it { is_expected.to include(:pole_emplois) }
      it { is_expected.to include(:apecs) }
      it { is_expected.to include(:cap_emplois) }
      it { is_expected.to include(:handicaps) }
      it { is_expected.not_to include(:housing_durations) }
      it { is_expected.not_to include(:housing_age) }
    end

    context 'when for housing social right' do
      let(:social_right) { create(:social_right, :housing) }

      it { is_expected.to include(:housing_durations) }
      it { is_expected.to include(:housing_age) }
      it { is_expected.to include(:housing_statuses) }
      it { is_expected.to include(:resource) }
      it { is_expected.not_to include(:awarenesses) }
      it { is_expected.not_to include(:working_durations) }
      it { is_expected.not_to include(:working_age) }
    end
  end
end
