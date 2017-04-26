# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Generate slugs'
  task generate_slugs: :environment do
    [PublicService, ServiceOffering, SocialRight].each do |klass|
      klass.find_each(&:save)
    end
  end
end
