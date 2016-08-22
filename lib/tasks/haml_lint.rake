# encoding: utf-8
# frozen_string_literal: true

begin
  require 'haml_lint/rake_task'
  HamlLint::RakeTask.new
rescue LoadError
  task :haml_lint do
    # no-op in environments where haml-lint is not installed
  end
end
