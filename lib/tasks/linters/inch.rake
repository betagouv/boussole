# encoding: utf-8
# frozen_string_literal: true

namespace :linters do
  task inch: :environment do
    sh './bin/inch'
  end
end
