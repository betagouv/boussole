# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Nulify emails'
  task nulify_emails: :environment do
    [PublicService, ServiceOffering].each do |klass|
      klass.find_each do |record|
        record.update_attribute(:email, nil) if record.email && record.email.empty?
      end
    end
  end
end
