# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Data Migration'
  task migrate: :environment do
    # Generate slugs
    [PublicService, ServiceOffering, SocialRight].each { |klass| klass.find_each(&:save) }
  end
end
