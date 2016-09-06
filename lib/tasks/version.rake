# encoding: utf-8
# frozen_string_literal: true
begin
  require 'git-version-bump/rake-tasks'
rescue LoadError
  task :version do
    # no-op in environments where GitVersionBump is not installed
  end
end
