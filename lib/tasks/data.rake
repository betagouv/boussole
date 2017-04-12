# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Data Migration'
  task migrate: :environment do
    # Nulify emails
    [PublicService, ServiceOffering].each do |klass|
      klass.find_each do |record|
        record.update_attribute(:email, nil) if record.email && record.email.empty?
      end
    end

    # Generate slugs
    [PublicService, ServiceOffering, SocialRight].each do |klass|
      klass.find_each(&:save)
    end

    # Service offering's response time
    ServiceOffering.find_each do |record|
      record.update_attribute(:response_time_upper_bound, 7) if record.response_time_upper_bound.to_i.zero?
    end

    # Migrate service offering's social rights
    ServiceOffering.find_each do |record|
      if record.respond_to?(:social_rights)
        record.social_right =
          record.social_rights.find_by(name: 'Emploi') ||
          record.social_rights.find_by(name: 'Logement') ||
          record.social_rights.first

        record.save
      end
    end
  end
end
