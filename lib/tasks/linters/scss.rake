# encoding: utf-8
# frozen_string_literal: true

namespace :linters do
  task scss: :environment do
    sh './bin/scss-lint --config ./.scss-lint.yml'
  end
end
