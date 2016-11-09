# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Data Migration'
  task migrate: :environment do
    # Nulify emails
    [PublicService, ServiceOffering].each do |klass|
      klass.find_each { |record| record.update_attribute(:email, nil) if record.email && record.email.empty? }
    end

    # Generate slugs
    [PublicService, ServiceOffering, SocialRight].each { |klass| klass.find_each(&:save) }
  end
end
