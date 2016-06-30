# encoding: utf-8
# frozen_string_literal: true

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    # no-op in environments where RuboCop is not installed
  end
end
