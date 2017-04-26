# encoding: utf-8
# frozen_string_literal: true

namespace :linters do
  task yaml: :environment do
    sh 'yaml-lint config/data config/criteria'
  end
end
