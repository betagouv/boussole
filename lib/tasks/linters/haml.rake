# encoding: utf-8
# frozen_string_literal: true

namespace :linters do
  begin
    require 'haml_lint/rake_task'

    task haml: :environment do
      HamlLint::RakeTask.new do |task|
        task.files = %w(app/views)
      end
    end
  rescue LoadError
    task haml: :environment do
      # no-op in environments where haml-lint is not installed
    end
  end
end
