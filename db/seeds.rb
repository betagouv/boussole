# encoding: utf-8
# frozen_string_literal: true

seeds = YAML.load(File.read(Rails.root.join('config', 'seeds.yml')))

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
        description: offer
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

seeds['social_rights'].each do |name|
  SocialRight.find_or_create_by!(name: name)
end
