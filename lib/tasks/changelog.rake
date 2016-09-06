# encoding: utf-8
# frozen_string_literal: true
begin
  require 'github_changelog_generator/task'

  GitHubChangelogGenerator::RakeTask.new(:changelog)
rescue LoadError
  task :changelog do
    # no-op in environments where GitHubChangelogGenerator is not installed
  end
end
