# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc 'Data Migration'
  multitask migrate: %i(nulify_emails generate_slugs add_response_time migrate_social_rights create_criteria)
end
