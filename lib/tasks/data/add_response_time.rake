# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc "Add service offering's response time"
  task add_response_time: :environment do
    ServiceOffering.find_each do |record|
      record.update_attribute(:response_time_upper_bound, 7) if record.response_time_upper_bound.to_i.zero?
    end
  end
end
