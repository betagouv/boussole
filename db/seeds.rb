# encoding: utf-8
# frozen_string_literal: true

seeds = YAML.safe_load(File.read(Rails.root.join('config', 'seeds.yml')))

seeds['social_rights'].each do |name|
  SocialRight.find_or_create_by!(name: name)
end

seeds['public_services'].each_pair do |name, hash|
  instance_variable_set(
    "@#{name}",
    PublicService.find_or_create_by!(
      hash.reject { |key, _| key =~ /ext|offer/ }
    )
  )

  hash['offer'].each do |offer|
    instance_variable_get("@#{name}")
      .service_offerings
      .find_or_create_by!(
        title: offer,
        description: offer,
        social_right: SocialRight.take
      )
  end
end

seeds['measures'].each_pair do |_, hash|
  instance_variable_get("@#{hash['public_service']}")
    .measures
    .find_or_create_by!(
      hash.reject { |key, _| key =~ /ext|public_service/ }
    )
end

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
