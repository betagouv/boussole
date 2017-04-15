# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TargetPublic, type: :model do
  it { is_expected.to belong_to(:service_offering) }

  it { is_expected.to have_many(:target_public_engagements) }
  it { is_expected.to have_many(:engagements).through(:target_public_engagements) }

  it { is_expected.to have_many(:target_public_last_classes) }
  it { is_expected.to have_many(:last_classes).through(:target_public_last_classes) }

  it { is_expected.to have_many(:target_public_experiences) }
  it { is_expected.to have_many(:experiences).through(:target_public_experiences) }

  it { is_expected.to have_many(:target_public_pole_emplois) }
  it { is_expected.to have_many(:pole_emplois).through(:target_public_pole_emplois) }

  it { is_expected.to have_many(:target_public_mission_locales) }
  it { is_expected.to have_many(:mission_locales).through(:target_public_mission_locales) }

  it { is_expected.to have_many(:target_public_cap_emplois) }
  it { is_expected.to have_many(:cap_emplois).through(:target_public_cap_emplois) }

  it { is_expected.to have_many(:target_public_housing_statuses) }
  it { is_expected.to have_many(:housing_statuses).through(:target_public_housing_statuses) }

  it { is_expected.to have_many(:target_public_housing_durations) }
  it { is_expected.to have_many(:housing_durations).through(:target_public_housing_durations) }
end
