# encoding: utf-8
# frozen_string_literal: true

namespace :linters do
  task i18n: :environment do
    sh 'i18n-tasks health'
  end
end
