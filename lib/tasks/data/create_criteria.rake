# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Find or create records needed for matching'
  task create_criteria: :environment do
    APECS            .each { |status| Apec.find_or_create_by!(value: status) }
    AWARENESSES      .each { |status| Awareness.find_or_create_by!(name: status) }
    CAP_EMPLOIS      .each { |status| CapEmploi.find_or_create_by!(value: status) }
    ENGAGEMENTS      .each { |status| Engagement.find_or_create_by!(name: status) }
    EXPERIENCES      .each { |status| Experience.find_or_create_by!(value: status) }
    HANDICAPS        .each { |status| Handicap.find_or_create_by!(value: status) }
    HOUSING_DURATIONS.each { |status| HousingDuration.find_or_create_by!(name: status) }
    LAST_CLASSES     .each { |status| LastClass.find_or_create_by!(name: status) }
    MISSION_LOCALES  .each { |status| MissionLocale.find_or_create_by!(value: status) }
    POLE_EMPLOIS     .each { |status| PoleEmploi.find_or_create_by!(value: status) }
    STATUSES         .each { |status| HousingStatus.find_or_create_by!(name: status) }
    STATUSES         .each { |status| WorkingStatus.find_or_create_by!(name: status) }
    WORKING_DURATIONS.each { |status| WorkingDuration.find_or_create_by!(name: status) }
  end
end
