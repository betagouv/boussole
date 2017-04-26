# encoding: utf-8
# frozen_string_literal: true

namespace :linters do
  desc 'Run all linters for this project.'
  multitask all: %i(i18n haml scss yaml inch rubocop)
end
