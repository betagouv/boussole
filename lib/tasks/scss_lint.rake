# encoding: utf-8
# frozen_string_literal: true

task :scss_lint do
  sh './bin/scss-lint --config ./.scss-lint.yml'
end
