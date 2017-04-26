# encoding: utf-8
# frozen_string_literal: true

namespace :data do
  desc "Migrate service offering's social rights"
  task migrate_social_rights: :environment do
    ServiceOffering.find_each do |record|
      if record.respond_to?(:social_rights)
        record.social_right =
          record.social_rights.find_by(name: 'Emploi') ||
          record.social_rights.find_by(name: 'Logement') ||
          record.social_rights.first

        record.save
      end
    end

    ExerciseScope
      .where(exercisable_type: 'ServiceOffering')
      .find_each(&:delete)
  end
end
